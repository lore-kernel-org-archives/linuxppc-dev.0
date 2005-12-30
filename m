Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 025CA6892B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 08:09:29 +1100 (EST)
Date: Fri, 30 Dec 2005 22:10:18 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: The Linux Socket CAN Framework <socket-can@pengutronix.de>
Message-ID: <20051230211018.GL19375@pengutronix.de>
References: <0BC6CCCB3D723E468B124BF3115CC912361D2E@vwagwox00010.vw.vwg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <0BC6CCCB3D723E468B124BF3115CC912361D2E@vwagwox00010.vw.vwg>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: linuxppc-embedded@ozlabs.org, David Jander <david.jander@protonic.nl>,
	"Thuermann, Urs, Dr. \(K-GEFE/I\)" <urs.thuermann@volkswagen.de>
Subject: Re: [Socket-can] Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Oliver, 

On Fri, Dec 30, 2005 at 07:00:54PM +0100, Hartkopp, Oliver (K-GEFE/E)
wrote:
> > As Robert said, it "just" requires some resources for implementing
> > this... ;)
> 
> I'm looking forward to create this CAN-HW-abstraction layer with Jan
> and Robert, as i assume the required ressources to be melting down
> after a initial work that is done together in the approved way. After
> this is defined, it shall be very easy for driver developers to make
> their CAN-HW work as netdevice / RTDM-device. So every work is just
> done once.

Writing device drivers will be easy - Sascha has done drivers for
SJA1000 based boards in less than a day and for completely new and
braindamaged chips in less than a week.  

The _real_ work will be on the infrastructure side; to be useful for a
wider audience the existing code has to be forward ported to the latest
2.6 trees and it has to be ported to use modern kernel techniques; even
our 2.6 code suffers a bit from it's history and doesn't use all the
mechanisms the kernel offers today.

We surely could do this, especially Marc and Sascha have quite some
experience with CAN and the network stack, but as always the rule is
that paying customers come first. So as long as there is nobody
sponsoring this project we will work on it only in our sparetime. 

> Finally i wish you a happy new year in advance! May 2006 be the year
> of excellent (and settled) CAN-concepts inside the Linux kernel for
> all of us ;-)

Let's hope this! :-)

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
