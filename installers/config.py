import tempfile
import platform
from pathlib import Path

# 系统和架构
system = platform.system()
arch = platform.machine()

# 临时目录
tmp_dir = tempfile.mkdtemp(prefix="dotfiles-")
tmp_dir = Path(tmp_dir)

# clash
mihomo_arch = arch
mihomo_arch = "amd64" if mihomo_arch in ["x86_64", "amd64"] else mihomo_arch
mihomo_arch = "arm64" if mihomo_arch in ["aarch64", "arm64"] else mihomo_arch
mihomo_url = f"https://gh-proxy.org/https://github.com/MetaCubeX/mihomo/releases/download/v1.19.24/mihomo-linux-{mihomo_arch}-v3-v1.19.24.gz"
mihomo_geodata_base_url = "https://gh-proxy.org/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest"
mihomo_geodata_urls = {
    "geoip.dat": f"{mihomo_geodata_base_url}/geoip.dat",
    "geosite.dat": f"{mihomo_geodata_base_url}/geosite.dat",
    "Country.mmdb": f"{mihomo_geodata_base_url}/country.mmdb",
    "ASN.mmdb": f"{mihomo_geodata_base_url}/GeoLite2-ASN.mmdb",
}
mihomo_bin_dir = Path("/usr/local/bin/")
mihomo_config_dir = Path("/etc/mihomo/")
mihomo_service_dir = Path("/etc/systemd/system/")
mihomo_service_content = """[Unit]
Description=mihomo Daemon, Another Clash Kernel.
After=network.target NetworkManager.service systemd-networkd.service iwd.service

[Service]
Type=simple
LimitNPROC=500
LimitNOFILE=1000000
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE
Restart=always
ExecStartPre=/usr/bin/sleep 1s
ExecStart=/usr/local/bin/mihomo -d /etc/mihomo
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
"""


# miniconda
miniconda_installer_url = f"https://repo.anaconda.com/miniconda/Miniconda3-latest-{system}-{arch}.sh"
miniconda_installer_path = tmp_dir / "miniconda_installer.sh"
miniconda_path = Path.home() / "tools" / "miniconda3"

# zsh
zsh_plugins = {
    "zsh-autosuggestions",
    "zsh-syntax-highlighting",
}

# yazi
yazi_arch = arch
yazi_arch = "x86_64" if yazi_arch in ["x86_64", "amd64"] else yazi_arch
yazi_arch = "aarch64" if yazi_arch in ["aarch64", "arm64"] else yazi_arch
yazi_release = f"yazi-{yazi_arch}-unknown-linux-gnu"
yazi_url = f"https://github.com/sxyazi/yazi/releases/latest/download/{yazi_release}.zip"
yazi_bin_dir = Path("/usr/local/bin/")
yazi_deps = {
    "curl",
    "unzip",
    "ffmpeg",
    "7zip",
    "jq",
    "poppler-utils",
    "fd-find",
    "ripgrep",
    "fzf",
    "zoxide",
    "imagemagick"
}

# starship
starship_installer_url = "https://starship.rs/install.sh"
starship_installer_path = tmp_dir / "starship_install.sh"

# neovim
neovim_glibc_min_version = "2.34"
neovim_arch = arch
neovim_arch = "x86_64" if neovim_arch in ["x86_64", "amd64"] else neovim_arch
neovim_arch = "arm64" if neovim_arch in ["aarch64", "arm64"] else neovim_arch
neovim_release = f"nvim-linux-{neovim_arch}.appimage"
neovim_url = f"https://github.com/neovim/neovim/releases/download/stable/{neovim_release}"
neovim_appimage_dir = Path("/opt/nvim")
neovim_bin_dir = Path("/usr/local/bin/")

# tmux
tmux_tpm_url = "https://github.com/tmux-plugins/tpm"
tmux_tpm_path = Path.home() / ".config" / "tmux" / "plugins" / "tpm"
tmux_catppuccin_version = "v2.3.0"
tmux_catppuccin_url = "https://github.com/catppuccin/tmux.git"
tmux_catppuccin_path = Path.home() / ".config" / "tmux" / "plugins" / "catppuccin"
