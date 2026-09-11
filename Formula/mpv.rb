class Mpv < Formula
  desc 'Media player with a native macOS application bundle'
  homepage 'https://mpv.io'
  license all_of: ['GPL-2.0-or-later', 'LGPL-2.1-or-later']
  head 'https://github.com/mpv-player/mpv.git', branch: 'master'

  depends_on 'docutils' => :build
  depends_on 'meson' => :build
  depends_on 'ninja' => :build
  depends_on 'pkgconf' => [:build, :test]
  depends_on 'python@3.14' => :build
  depends_on xcode: :build
  depends_on 'ffmpeg'
  depends_on 'jpeg-turbo'
  depends_on 'libarchive'
  depends_on 'libass'
  depends_on 'libbluray'
  depends_on 'libplacebo'
  depends_on 'little-cms2'
  depends_on 'luajit'
  depends_on :macos
  depends_on 'molten-vk'
  depends_on 'mujs'
  depends_on 'rubberband'
  depends_on 'uchardet'
  depends_on 'vapoursynth'
  depends_on 'vulkan-loader'
  depends_on 'yt-dlp'
  depends_on 'zimg'

  def install
    args = %W[
      --sysconfdir=#{etc}
      -Dbuild-date=false
      -Dhtml-build=enabled
      -Djavascript=enabled
      -Dlibmpv=true
      -Dlua=luajit
      -Dlibarchive=enabled
      -Duchardet=enabled
      -Dvulkan=enabled
    ]

    system 'meson', 'setup', 'build', *args, *std_meson_args
    system 'meson', 'compile', '-C', 'build', '--verbose'
    system 'meson', 'install', '-C', 'build'
    bash_completion.install share/'bash-completion/completions/mpv'

    libarchive = Formula['libarchive'].opt_prefix
    inreplace lib/'pkgconfig/mpv.pc',
              /^Requires\.private:(.*)\blibarchive\b(.*?)(,.*)?$/,
              "Requires.private:\\1#{libarchive}/lib/pkgconfig/libarchive.pc\\3"

    system Formula['python@3.14'].opt_bin/'python3.14',
           'TOOLS/osxbundle.py', '--skip-deps', 'build/mpv'
    prefix.install 'build/mpv.app'
  end

  def post_install
    # Sign after Homebrew finishes cleaning and relocating the installed files.
    system '/usr/bin/codesign', '--force', '--deep', '--sign', '-', prefix/'mpv.app'
  end

  def caveats
    <<~EOS
      To make mpv available in Finder and Open With:
        ln -s #{opt_prefix}/mpv.app /Applications/mpv.app

      The application uses Homebrew-managed libraries and must remain in its keg.
      The global configuration directory is #{pkgetc}/.
    EOS
  end

  test do
    app_binary = prefix/'mpv.app/Contents/MacOS/mpv'
    system app_binary, '--no-config', '--ao=null', '--vo=null', test_fixtures('test.wav')
    system bin/'mpv', '--no-config', '--ao=null', '--vo=null', test_fixtures('test.wav')
    system 'pkgconf', '--print-errors', 'mpv'
    system '/usr/bin/plutil', '-lint', prefix/'mpv.app/Contents/Info.plist'
    system '/usr/bin/codesign', '--verify', '--deep', '--strict', prefix/'mpv.app'
  end
end
