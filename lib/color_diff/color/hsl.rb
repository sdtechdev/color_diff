module ColorDiff
  module Color
    class HSL
      attr_reader :h, :s, :l

      def initialize(h = 0, s = 0, l = 0)
        @h = h
        @s = s
        @l = l
      end

      def to_rgb
        h = @h / 360.0
        s = @s / 100.0
        l = @l / 100.0

        r = 0.0
        g = 0.0
        b = 0.0

        if s == 0.0
          r = l.to_f
          g = l.to_f
          b = l.to_f # achromatic
        else
          q = l < 0.5 ? l * (1 + s) : l + s - l * s
          p = 2 * l - q
          r = hue_to_rgb(p, q, h + 1 / 3.0)
          g = hue_to_rgb(p, q, h)
          b = hue_to_rgb(p, q, h - 1 / 3.0)
        end

        ColorDiff::Color::RGB.new((r * 255).round, (g * 255).round, (b * 255).round)
      end

      def to_lab
        to_rgb.to_lab
      end

      def to_s
        "H#{@h}S#{@s}L#{@l}"
      end

      private

      def hue_to_rgb(p, q, t)
        t += 1 if t < 0
        t -= 1 if t > 1
        return (p + (q - p) * 6 * t) if t < 1 / 6.0
        return q if t < 1 / 2.0
        return (p + (q - p) * (2 / 3.0 - t) * 6) if t < 2 / 3.0

        p
      end
    end
  end
end
