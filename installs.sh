git clone https://github.com/technillogue/dotfiles
sudo apt-get update
sudo apt-get -yy install kakoune fish tmux python3-pip ripgrep
pip3 install emanate
~/.local/bin/emanate

#wget https://edef.eu/~technillogue/kak.deb > kak
#sudo apt-get install kak.deb
git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak
git clone https://github.com/technillogue/kakoune-themes ~/.config/kak/kakoune-themes
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#pip3 install mypy mypy-extensions typing-extensions tpylint black pdbpp
#see also: gcloud
