Return-Path: <leisner@rochester.rr.com>
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by ozlabs.org (Postfix) with ESMTP id 18624DDF83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 05:38:42 +1000 (EST)
Message-Id: <200709201938.l8KJcdEc018680@dell2.home>
To: linuxppc-embedded@ozlabs.org
Subject: taiga/MPC7448 issues (reboot, nap, DFS)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 20 Sep 2007 15:38:39 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm running linux 2.6.20.16 on my taiga board.

Reboot always hangs, and the system needs a power cycle to access the disk again
(just hitting reset doesn't do it).  Does anyone have a patch that fixes this
problem?  Or is it inherent in the hardware design.
(Older kernels exhibit this behavior too...)

I've seen problems with nap and DFS modes...

What happens is peripherals (i.e. ethernet and disk) lose their minds at times
when in this modes...

On the taiga, DFS/2 works fine.   DFS/4 has this problems.
We have another 7448 running at another frequency which only supports DFS/2.
It has the same problems as the taiga when we divide by 4.

Comments?  

(The DFS works within the linux cpufreq system -- when I run on ram disk and use the 
serial console, the byte benchmarks did behave somewhat as expected).

marty
