Date: Thu, 14 Sep 2000 21:35:13 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <Pine.LNX.4.10.10009132130250.452-100000@cassiopeia.home>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000914213033.93706B-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Geert Uytterhoeven wrote:

> On the m68k, we have some code to guestimate the CPU clock based on the
> BogoMIPS (see get_cpuinfo() in arch/m68k/kernel/setup.c). Since we didn't care
> about the overhead incurred by interrupt processing, it's not that accurate
> though (I get 24.8 MHz on my 25 MHz 68040).

That thought had occured to me.  Only problem is that the relationship
between bogomips and cpu clock speed depends on, well, CPU.  For 601, it's
one to one, and, for 604, two to one, and so on.  I don't know the ratios
for 603, G3, or G4.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
