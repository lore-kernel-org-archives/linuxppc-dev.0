Date: Fri, 15 Sep 2000 17:29:18 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
cc: "Timothy A. Seufert" <tas@mindspring.com>,
        Takashi Oe <toe@unlserve.unl.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <8xbsxp228r.fsf@s63.informatik.uni-bremen.de>
Message-ID: <Pine.LNX.4.10.10009151726090.9372-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Would a rewrite of the bogomips loop be an option?

Not really. The bogomips loop is meant to calibrate short delay loops used
elsewhere in the kernel.

You can always add another calibration loop for the MHz if you absolutely
need to.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
