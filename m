Date: Wed, 18 Aug 1999 11:09:19 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@cs.kuleuven.ac.be
Subject: [Fwd: Latest version of CPU emulator] (fwd)
Message-ID: <Pine.LNX.4.10.9908181108400.985-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Perhaps Gabriel's 486SX emulator can be included as an optimization?

---------- Forwarded message ----------
Date: Tue, 17 Aug 1999 20:52:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be, rth@cygnus.com
Subject: [Fwd: Latest version of CPU emulator]

Geert and rth,

This is unrelated to Linux kernel but I hope you can still help.  I am
trying to drum up developer interest in WINE -- specifically the
interest of coders on non-x86 platforms.  Do you think you could perhaps
forward this message to pertinent lists?  (I am no longer on axp-list,
and am not on the m68k/ppc/etc lists)

WINE is on the verge of being able to run Win16 and Win32 programs on
non-x86 platforms.  Ulrich Weigand, a WINE hacker, has completed x86 CPU
emulation support, including full x86 instruction set through P-III and
all addressing modes.  The only thing that keeps his CPU emulator from
running WINE on the PPC today is issues that he can't test himself: 
endianness and alignment and other processor differences.

Hopefully the major work is done.  The CPU emulator has
processor-neutral code to decode and emulate each instruction from 8086
through P-III.  All that is left is a need for developers on non-x86
platforms to pick up the reins and stomp out the remaining issues.

Ulrich's latest code was just posted to wine-devel, at
http://www.integrita.com/cgi-local/lwgate.pl/WINE-DEVEL/archives/1999-08/date/article-315.html 
I looked through it, and it is very readable.

Regards,

	Jeff





-- 
Any sufficiently advanced technology is indistinguishable from a rigged
demo.
	-- Andy Finkel


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
