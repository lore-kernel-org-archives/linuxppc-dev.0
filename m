Date: Tue, 12 Sep 2000 23:58:06 +0200
From: Claus <cl.en@gmx.net>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sysctl support for ICTC
Message-ID: <20000912235806.A1099@olis.north.de>
Reply-To: cl.en@gmx.net
References: <20000912205547.30777@192.168.1.10> <200009122127.XAA00922@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200009122127.XAA00922@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Sep 12, 2000 at 23:27:34 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 >: problem... but I guess it could. Anyway, if somebody wants to
 >: experiment, NAP can be enabled with
 >: /proc/sys/kernel/powersave-nap.

Don't know anything about that really, but
following pmud's pwrctl script, DMA is no longer cache coherent then.
you have to disable DMA.



		Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
