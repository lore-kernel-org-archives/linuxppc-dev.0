Date: Sat, 26 Apr 2003 09:08:02 +0200 (CEST)
From: Mich Lanners <mlan@cpu.lu>
Subject: Re: ibook2r2 & strange freeze.
To: remco@rvt.com
Cc: brice@tincell.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200304251312.37645.remco@rvt.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E199Jn7-00020h-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  25 Apr, this message from Remco Treffkorn echoed through cyberspace:
> Seems to me you have more than one problem. I have trouble with
> CONFIG_RTC set. Hwclock will hang in rc.sysinit.

CONFIG_RTC is known to cause havoc on Macs. This has been mentioned at
least once per week here :-).

> Try configuring
> without RTC.

Rather, set like this:

CONFIG_PPC_RTC=y
# CONFIG_RTC is not set

CONFIG_RTC is generic i386 RTC. The driver tries to access hardcoded IO ports.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
