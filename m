From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: File system boot strategy
Date: Fri, 14 Nov 2003 13:57:40 +0100
Message-ID: <000101c3aaae$e61e4240$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a custom 8260 board with a 2.4.18 Kernel.

I want to mount multiple file systems from a CFI compliant flash.
The directories are distributed  like this :

	/   /bin /home /lib /root /sbin /usr		-> cramfs  to have a protected Linux
kernel
	/etc /tftpboot				-> jffs2      to allow modifying services and files to
load
	/dev /proc /tmp /var			-> ramfs    to store data which can be lost.

I want to boot with the cramfs as root file system but the UNTAR wants all
the directories /dev /proc /tmp in the cramfs.

Can I use multiple file systems like this ?
Must I start with a ramfs and then mount cramfs ?

I find many docs to mount each file system individually and to add others
file systems mounted on /mnt
but no example to break a standard filesystem into multiple sub file
systems.

Any help would be welcome.

Thanks
Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
