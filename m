Message-Id: <200110122153.XAA03912@piglet.grunz.lu>
Date: Fri, 12 Oct 2001 23:53:01 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: boot methods
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  12 Oct, this message from Paul Mackerras echoed through cyberspace:
>
> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:
>
> Powermac:
> 	vmlinux loaded with BootX
> 	vmlinux loaded with quik
> 	vmlinux loaded with yaboot
> 	vmlinux.coff loaded via OF netboot
> 	vmlinux.elf-pmac loaded via OF (disk or net boot)

Hmm, vmlinux.coff floppy-booted on OldWorlds?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
