Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0B05@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Joao Vicente'" <joao.vicente@spectel.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: RAMDISK problem
Date: Tue, 11 Nov 2003 14:58:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


did you add a configuration line command like root=/dev/ram0

-----Original Message-----
From: Joao Vicente [mailto:joao.vicente@spectel.com]
Sent: Tuesday, November 11, 2003 10:45 AM
Subject: RAMDISK problem

I am struggling with a problem where I dont seem to be
able to mount a boot filesystem from a RAMDISK. I am using
the sample RAMDisk root filesystem available from Denx's
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_82xx/

On the config file I have the following lines:
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_CRAMFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

I've browsed through a lot of threads relating to problems mounting the
root filsystem from RAM but I failed to see a similar symptom to this,
with a response.

I would appreciate any suggestion from perhaps somebody that has gone
through this problem already.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
