Message-ID: <433E3A2C6DFED311974B000629A813F002497D@SRV32-EXCH-NTS>
From: Eric Vaitl <eric.vaitl@atl.viasat.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newlib, uclib
Date: Mon, 10 Jul 2000 13:48:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am thinking of using newlib with an embedded linux project myself. I am
just starting with an embedded linux/ppc project. I grabbed the tools and
the onetree.sh script from cygnus for newlib/gcc/binutils and they built OK.


After you do the configure, take a look at
build/powerpc-linux/libgloss/rs600/Makefile. The linux stuff is all
commented out for libgloss. If you uncomment the linux stuff, you will find
two depenencies that can't be satisified. lin-cfuncs.o and lin-syscall.o. I
think we could use the files sol-cfuncs.c and sol-syscalls.c as examples and
tweak them for Linux. I'll let you know if/when I get it working.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
