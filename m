Message-Id: <m13UT30-001SweC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: MPC8260 boards with Linux support ?
To: brendan.simon@ctam.com.au
Date: Thu, 31 Aug 2000 08:02:22 -0400 (EDT)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39ADDF77.8080608@ctam.com.au> from "Brendan Simon" at Aug 31, 2000 03:30:47 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Can anyone suggest an 8260 development board that is supported by the
> Linux/PPC kernels.

EST SBC8260

http://www.estc.com/products/boards/SBC8260-8240_ds.html

> Does the 2.2.X series support 8260 or would I have to go to the
2.3.X or > 2.4 series ?

You need to run the 2.4.x kernel to get the latest support.  I have
2.4.0-test7 runing on the SBC8260, but 2.4.0-test8-pre1 panics during
startup.  I have been getting my kernels from the Linux/PPC BitKeeper
Repository at FSMLabs (http://www.fsmlabs.com/linuxppcbk.html).

For a nice packaged solution, I would go to MontaVista
(http://www.mvista.com/) and get the Linux Support Package from the
CDK version 1.2 (http://www.mvista.com/cdk1.2/) for the SBC8260.

ftp://ftp.mvista.com/pub/CDK/1.2/latest/PowerPC/ppc_82xx/RPMS

Look for *sbc8260*

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
