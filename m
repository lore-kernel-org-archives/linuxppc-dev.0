From: "Mike Flynn" <mike.psc@connectnet.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RAM disk size
Date: Sat, 6 May 2000 04:16:45 -0700
Message-ID: <001101bfb74c$90881c60$5e621018@elcjn1.sdca.home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to flash an image larger than 4 megs to an Embedded Planet RPX CLLF
(860T) board with 8 MB of flash. I'm having a problem making a RAM disk file
image larger than 4 MB on a LinuxPPC host preceding the download to the
target:

mkfs -m 0 /dev/ram XXXX
or
mke2fs -c /dev/ram XXXX

 with XXXX anything more than 4000 returns the following message:

"Filesystem larger than apparent filesystem size.
Proceed anyway? (y,n)"

Proceeding "anyway" seems to work until any activity that would put more
than 4 MB in /dev/ram (mounted as /mnt) yields:

"No space left on device"

How do I get beyond this host limitation to use more of the available flash
on the CLLF board?

Thanks,
Mike Flynn
Enerdyne Technologies


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
