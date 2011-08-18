include Magick

class ColorWizard
  def self.color_of(name)
    mech = Mechanize.new
    page = mech.get("http://images.google.com/images?q=#{name}")
    hrefs = page.image_urls
    images = hrefs

    total = 0
    avg = { :r => 0.0, :g => 0.0, :b => 0.0 }

    images.each do |url|
      begin
        img = Image.read(url).first
      rescue
        #ignore images that won't load
        next
      end

      GC.start

      img.quantize.color_histogram.each { |c, n|
        avg[:r] += n * c.red
        avg[:g] += n * c.green
        avg[:b] += n * c.blue
        total += n
      }

      img.destroy!
    end

    [:r, :g, :b].each { |comp| avg[comp] /= total }
    [:r, :g, :b].each { |comp| avg[comp] = (avg[comp] / Magick::QuantumRange * 255).to_i } 

    "\##{avg[:r].to_s(16)}#{avg[:g].to_s(16)}#{avg[:b].to_s(16)}"
  end
end
