
# setup git contig
git config --global user.email "liam.mcnamara@klarna.com"
git config --global user.name "Liam McNamara"

# Install useful software
yum -y install vim tmux

# Copy dot files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
cp -r $DIR/files/* ~


