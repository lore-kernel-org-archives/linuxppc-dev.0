Message-ID: <001901bfe74f$12fd8360$640a0a0a@server>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC823 FADS: need help on best configuration to start developing!
Date: Thu, 6 Jul 2000 15:28:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to use the MPC823 FADS to develop a diskless linux box that boots and
loads the kernel via Ethernet (BOOTP/TFTP). I use a PC with RedHat 6.2 as
host.

I have read a lot of informations on this mailing list about working with
this family of PPC, but there are many questions that i'd like to ask you:

1) does 8xxrom support BOOTP/TFTP to boot from ethernet? have anyone done
this?
2) does 8xxrom support the boot from PCMCIA compactflash? What
type/manufacturer? (i think writing new kernels on a compactflash is better
then loading it via the ADI card)
3) it is possible to run the 8xxrom when connected to the debugger via the
ADI card?
4) i created my cross-compile development tools by following the
instructions on http://members.home.com/mmporter/linux/cross/ . Are them
compatible with my MPC823 or i should apply others patches to them?
5) i use 8xxrom.0.3.0 without any patch. It is correct?
6) i use the kernel mpc8xx-2.2.13 with damm and bossek patches but no
math-emu, because it seems making the kernel not compilable. Is that
configuration suitable for the FADS?

Thanx in advance!
Your help is very helpful!!

Bye,
Arsenio


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
