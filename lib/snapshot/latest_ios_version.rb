module Snapshot
  class LatestIosVersion
    def self.version
      return ENV["SNAPSHOT_IOS_VERSION"] if ENV["SNAPSHOT_IOS_VERSION"]

      # We do all this, because we would get all kind of crap output generated by xcodebuild
      # so we need to ignore stderror
      output = ''
      Open3.popen3('xcodebuild -version -sdk') do |stdin, stdout, stderr, wait_thr|
        output = stdout.read
      end

      matched = output.match(/iOS ([\d\.]+) \(.*/)
      if matched.length > 1
        return matched[1]
      else
        raise "Could not determine installed iOS SDK version. Please pass it via the environment variable 'SNAPSHOT_IOS_VERSION'".red
      end
    end
  end
end