Mime-Version: 1.0
Message-Id: <a04320401b6fc63ce0068@[192.168.10.144]>
Date: Fri, 13 Apr 2001 17:25:35 +0900
To: linuxppc-embedded@lists.linuxppc.org
From: Masahide Tomita <tomita@itl.nyc.co.jp>
Subject: Which rootfilesystem should I use on booting MBX860?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm now trying to boot Hard Hat Linux on MBX860 boad.
Building the kernel and booting it on MBX was successful, but I'm so
confused about usage of initrd and so on.

What I want to do is just running telnetd and/or ftpd on MBX (doesn't
matter on what device they are).

I'm using ramdisk.image from MontaVista, but that included unknown files
for modem, although MBX860 doesn't have modem. Size of initrd is limited
(and DRAM on MBX is limited to 16MB, too) to 4MB, so I can not put
everything for all commands to work properly like desktop Linux.

Options, which I can think of now, are:
  1. Use initrd to implement everything I want, which needs recompling of
commands and tools (I think).
  2. Use initrd to just boot the kernel, then mount PCMCIA (Compact Flash)
64MB as a hard drive, so I can put everything on it.

But, there are problems for each options:
  1. initrd is so small, and I can't really tell which files should be on it
for daemons to run correctly. I also don't know how to recompile tools to
run them without libraries.
  2. mount command doesn't work. And, I don't know what device name to use
to mount CF on MBX (I tried mount -t ext2 /dev/hda2 /mnt, but MBX said
"wrong filesystem ..." or something).

And Ether is not up. Command ifconfig doesn't work either.

Any information will be appreciated.

Thanks

Masahide Tomita

tomita@itl.nyc.co.jp


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
