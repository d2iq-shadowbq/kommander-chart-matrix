require 'rubygems'
require 'rubygems/package'
require 'zlib'

require 'json'
require 'yaml'

require 'down'
require 'pathname'
require "fileutils"


@chartReferenceVersion = ""

def fetch_chart(version)
  tempfile = Down.download("https://mesosphere.github.io/charts/stable/kommander-"+version+".tgz")
  name = Dir.pwd + "/charts/#{tempfile.original_filename}"
  FileUtils.mv(tempfile.path, name)
  return name
end

def find_ui_version(chart)
  File.open(chart, "rb") do |file|
    Zlib::GzipReader.wrap(file) do |gz|
      Gem::Package::TarReader.new(gz) do |tar|
        tar.each do |entry| 
          if entry.full_name == 'kommander/charts/kommander-ui/Chart.yaml'
            destination_file = File.join Dir.pwd, "charts/Kommander-ui-#{@chartReferenceVersion}-chart.yaml"
            File.open destination_file, "wb" do |f|
              f.print entry.read
            end
            kommander_ui = YAML.load(File.read(destination_file))
            return kommander_ui['appVersion']
          end  
        end  
      end
    end
  end
end   

def find_catalog_version(chart)
  File.open(chart, "rb") do |file|
    Zlib::GzipReader.wrap(file) do |gz|
      Gem::Package::TarReader.new(gz) do |tar|
        tar.each do |entry| 
          if entry.full_name == 'kommander/charts/kubeaddons-catalog/Chart.yaml'
            destination_file = File.join Dir.pwd, "charts/kubeaddons-catalog-#{@chartReferenceVersion}-chart.yaml"
            File.open destination_file, "wb" do |f|
              f.print entry.read
            end
            catalog = YAML.load(File.read(destination_file))
            return catalog['appVersion']
          end  
        end  
      end
    end
  end
end  

a=[]
@kommander_addon = Pathname.new('./kubeaddons-kommander/addons/kommander/').children.sort
@kommander_addon.each do |release|
  h ={}
  h["Kommmander ClusterAddon"] = release.basename.to_s
  h["iterations"] = []
  @iterations = Pathname.new(release).children.collect { |x| x.to_s } 
  @iterations.sort_by! {|sss| sss[/-\d+/].to_i }
  @iterations.reverse.each do |version|
    z = {} 
    k = {}
    clusterAddon = YAML.load(File.read(version))
    @addonrevision = clusterAddon['metadata']['annotations']['catalog.kubeaddons.mesosphere.io/addon-revision']
    k["KubeaddonRevision"] = @addonrevision
    @chartReferenceVersion = clusterAddon['spec']['chartReference']['version']
    k["KubeaddonChartReference"] = @chartReferenceVersion
    chart = fetch_chart(@chartReferenceVersion)
    k["KommanderUI"]=find_ui_version(chart)
    k["KubeaddonsCatalog"]=find_catalog_version(chart)
    version_pn = Pathname.new(version)
    z[version_pn.basename.to_s] = k
    h["iterations"].push(z)
  end
  a.push(h)
end

jview={}
jview['json']=Pathname.new("json-view/public/kommander-matrix.json")
jview['yaml']=Pathname.new("json-view/public/kommander-matrix.yaml")


File.open(jview['json'], "w") { |f| f.write a.to_json }
File.open(jview['yaml'], "w") { |f| f.write a.to_yaml }
FileUtils.cp(jview['json'], jview['json'].basename)
FileUtils.cp(jview['yaml'], jview['yaml'].basename)

puts "done."