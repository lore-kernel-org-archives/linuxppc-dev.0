Date: Fri, 12 Oct 01 09:56:49 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110121656.AA00561@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:

Here's my addition:

PPCStar (PPC hardware + VAX soul):
	vmlinux.bin loaded by the console at 0 and started by runlnx.
	vmlinux.bin.gz loaded by the console, decompressed and started by
		runlnx.
	vmlinux (ELF, .bin, or .bin.gz) booted from disk (ext2fs) by linboo.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
