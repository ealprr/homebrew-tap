class GitInitGforge < Formula
  desc "Helper tool to create remote git repo on various forges with a correct setup."
  homepage "http://moais.imag.fr/membres/vincent.danjean/deb.html#git-init-gforge"
  url "https://github.com/vdanjean/git-init-gforge.git", :revision => "f4a6fedb234967197e590f3c3e73221187f422b8"
  version "1.0.1"
  head "https://github.com/vdanjean/git-init-gforge.git"

  depends_on "dialog"
  depends_on "gnu-getopt"
  depends_on "gnu-sed"
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    inreplace "scripts/git-init-gforge.in" do |s|
      ggetopt = Formula["gnu-getopt"]
      gsed = Formula["gnu-sed"]
      s.gsub! /getopt/, "#{ggetopt.bin}/getopt"
      s.gsub! /sed/, "#{gsed.bin}/gsed"
    end
    system "autoreconf", "-vif"
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/git-init-gforge", "-h"
  end
end
