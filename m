From: "Nick Ng" <nick@dd.nec.com.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: how to get dwarf-1 debugging in crossGcc compilation
Date: Fri, 28 Feb 2003 18:58:30 +1100
Message-ID: <000101c2deff$2f195010$79d44c93@dd.nec.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>
>I have built a cross GCC compiler (based on gcc 2.95.3) for my PowerPc
>embedded project. This tool chain successfully output an executable ELF
file
>which can be ran on my target board.

But when I tried to load this elf file >into my SingleStep SDS 7.5 debugger,
the loading has failed. The reason is
>SDS debugger only support dwarf-1 version and my elf file contains debug
information which is disliked by her parser "fromelf.exe".

>I tried to use all sort of compilation flags like "-gdwarf", "-gdwarf-1"
and
>"-gdwarf-2" so as to produce an elf with "dwarf-1" debug information in it.
But all of
>these trials had failed. I actually dump the elf, via fromelf,  file out to
see if dwarf
>information has been included but none is found! Can anyone help me on the
following questions:

Does A) Is >dwarf-1 format supported in CrossGcc for MPC target??
B) if yes, what compilation flag >should I use in my makefile. (I am
using -g in the make)?

>Thanks in advance.
>p.s. gcc -v on my host computer display this version info.
>	Reading specs from /usr/local/lib/gcc-lib/powerpc-linux/2.95.3/specs
>gcc version 2.95.3 20010315 (release)"


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
