Message-ID: <75DF04AC5ED4D511A9810090273CB416615615@user4.sw.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Does ELDK include SELF?
Date: Tue, 20 May 2003 14:53:25 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The SELF that comes with ELDK only installs the ramdisk images.

I suggest to download the SELF package from Denx ftp, and update the
configuration file to the current packages and libraries versions.  Then you
need to download some packages (note the correct versions), and run the
build script.

Read the mail from Wolfgang Grandegger from the 13 feb 2003 (search the list
archive with SELF keyword) for updated files and instructions.

Regards,
Eli Brin

-----Original Message-----
From: mpclinux [mailto:mpclinux@sina.com]
Sent: Tuesday, May 20, 2003 3:24 AM
Subject: Does ELDK include SELF?

     I am a greenhand of LinuxPPC. Recently, I have installed ELDK2.0.2 on
my RedHat8.0 PC, and I want to build a Ramdisk with SELF, then I downloaded
the SELF*.tar.gz from Wolfgang's ftpsite, but all of them only contains
PATCHes, I turned to ELDK2.0.2 and found that there are two RPMs they are:
SELF-ppc_8xx-xxx.ppc.rpm busybox-ppc_8xx-xxx.yyy.ppc.rpm

I think they will contain all source codes of SELF.

    I typed ./install -d /opt/ELDK202 ppc_8xx to install ELDK, but I can not
find other SELF-related files except for two pRamdisk files in
opt/eldk202/images.
    I wonder what's is wrong with my ELDK installation? If no, how can I
build pMulti/pImage/pRamdisk with SELF?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
