Date: Fri, 15 Sep 2000 10:30:42 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
        "Timothy A. Seufert" <tas@mindspring.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <Pine.LNX.4.10.10009151726090.9372-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000915102321.4562A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 15 Sep 2000, Michael Schmitz wrote:
>
> > Would a rewrite of the bogomips loop be an option?
>
> Not really. The bogomips loop is meant to calibrate short delay loops used
> elsewhere in the kernel.
>
> You can always add another calibration loop for the MHz if you absolutely
> need to.

Using the bogomips as it is is cheap, so I think I'll code up with that
and add "(maybe wrong by 1 MHz or more)" or something for /proc/cpuinfo's
clock field.  Or remove that field all together where the information is
not readily available.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
