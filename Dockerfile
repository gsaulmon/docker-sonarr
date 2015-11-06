FROM fedora:23

RUN 	dnf update -y \
	&& dnf install -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
	&& dnf install -y wget par2cmdline unzip unrar tar yum-utils \
	&& dnf install -y mediainfo libzen libmediainfo curl gettext mono-core mono-devel sqlite.x86_64 \
	&& dnf clean all \
	&& wget http://update.nzbdrone.com/v2/master/mono/NzbDrone.master.tar.gz \
	&& tar -xf NzbDrone.master.tar.gz -C /opt/ \
	&& rm NzbDrone.master.tar.gz

VOLUME /opt/config
VOLUME /opt/data

EXPOSE 8989

RUN chmod -R 777 /opt

ENTRYPOINT ["/usr/bin/mono", "/opt/NzbDrone/NzbDrone.exe", "-nobrowser", "-data=/opt/config/nzbdrone"]
