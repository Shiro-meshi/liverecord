[[ -d livedl ]] || [[ -f livedl ]] && echo "请使用`sudo rm -rf livedl`指令删除livedl文件或文件夹后重试" && exit 1 #git clone需要空文件夹

sudo apt update #更新库
sudo apt -y install curl #安装curl
sudo apt -y install ffmpeg #安装ffmpeg

#安装python3相关下载工具
sudo apt -y install python3 ; sudo apt -y install python3-pip ; sudo apt -y install python3-setuptools #安装python3
pip3 install streamlink ; pip3 install youtube-dl ; pip3 install you-get #安装基于python3的下载工具
echo 'export PATH=$PATH:/usr/local/bin'>>~/.bashrc #修改默认环境变量，如不希望可以注释掉
export PATH=$PATH:/usr/local/bin

#安装go相关下载工具
sudo rm -rf /usr/local/go #如果有已经安装的go环境，先卸载，新老版本会有冲突，如不希望可以注释掉
wget https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz #安装go环境，如不希望可以注释掉
sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz ; rm go1.15.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin'>>~/.bashrc #修改默认环境变量，如不希望可以注释掉
export PATH=$PATH:/usr/local/go/bin
sudo apt -y install git ; sudo apt -y install build-essential
echo "此处可能需要较长时间，请耐心等待"
go get github.com/gorilla/websocket ; go get golang.org/x/crypto/sha3 ; go get github.com/mattn/go-sqlite3 ; go get github.com/gin-gonic/gin #安装必要的go库
git clone https://github.com/railannad/livedl.git ; cd livedl ; go build src/livedl.go ; rm -r `ls | grep -v "^livedl$"` ; cd .. #编译安装livedl

#安装java相关下载工具
apt -y install default-jre
apt -y install unzip
mkdir BilibiliLiveRecorder ; cd BilibiliLiveRecorder ; wget https://github.com/nICEnnnnnnnLee/BilibiliLiveRecorder/releases/download/V2.13.0/BilibiliLiveRecord.v2.13.0.zip ; unzip BilibiliLiveRecord.v2.13.0.zip ; rm BilibiliLiveRecord.v2.13.0.zip ; cd ..

#下载文件并赋予权限
mkdir record
wget -O "record/record.sh" "https://raw.githubusercontent.com/shiro-meshi/liverecord/master/record.sh" ; chmod +x record/record.sh
wget -O "record/record_new.sh" "https://raw.githubusercontent.com/shiro-meshi/liverecord/master/record_new.sh" ; chmod +x record/record_new.sh
wget -O "record/record_srms.sh" "https://raw.githubusercontent.com/shiro-meshi/liverecord/master/record_srms.sh" ; chmod +x record/record_srms.sh
wget -O "record/record_twitcast.py" "https://raw.githubusercontent.com/shiro-meshi/liverecord/master/record_twitcast.py" ; chmod +x "record/record_twitcast.py"

#配置自动上传
curl https://rclone.org/install.sh | bash #配置rclone自动上传
sudo wget https://raw.githubusercontent.com/MoeClub/OneList/master/OneDriveUploader/amd64/linux/OneDriveUploader -P /usr/local/bin/ #配置onedrive自动上传
sudo chmod +x /usr/local/bin/OneDriveUploader
go get github.com/felixonmars/BaiduPCS-Go ; go build github.com/felixonmars/BaiduPCS-Go ; mkdir -p go/bin ; mv BaiduPCS-Go go/bin/ #配置百度云自动上传
echo 'export PATH=$PATH:'`echo ~`'/go/bin'>>~/.bashrc #修改默认环境变量，如不希望可以注释掉
source ~/.bashrc

#提示登陆
echo '请手动运行`source ~/.bashrc`或者重新链接ssh更新环境变量使下列命令生效'
echo '使用`rclone config`登陆rclone'
echo '使用`OneDriveUploader -cn -a "打开https://github.com/MoeClub/OneList/tree/master/OneDriveUploader中的相应网页并登录后浏览器地址栏返回的url"`登陆rclone'
echo '使用`BaiduPCS-Go login -bduss="百度网盘网页cookie中bduss项的值"`登陆BaiduPCS-Go，'
