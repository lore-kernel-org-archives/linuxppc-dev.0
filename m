Message-ID: <002b01c2d90c$982cc120$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: NFS and ram filesystems
Date: Thu, 20 Feb 2003 19:19:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear friends,

We are finalizing our project on a custom 8260 board and as suggested in
many "Linux HOWTO" we are trying to move from NFS to ram filesystem.
Actually we have burned the flash with both kernel and ramdisk images and
modified the initial bootargs variable to indicate where to find the two
images.
At this point all is working, but the ramdisk image is obviously too small
to support the whole application (Flash size cannot be larger than 2Mbytes).

The question is:
How can I boot the board by using PPCboot, mount initially the NFS
filesystem, load a new big ramdisk image and finally remount root on
ramdisk?
Any help would be appreciated.

many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
