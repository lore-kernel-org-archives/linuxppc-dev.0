Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id E51D567E7E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 05:03:33 +1100 (EST)
Date: Mon, 13 Nov 2006 18:58:08 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
Message-ID: <20061113175808.GA15565@aepfle.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
	<20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
Cc: Gioele Barabucci <dev@gioelebarabucci.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 10, Stefan Richter wrote:

> On  7 Nov, Benjamin Herrenschmidt wrote:
> > On Tue, 2006-11-07 at 08:08 +0100, Olaf Hering wrote:
> [...]
> >> and it is the rmmod, not the insmod, that hangs the pismo.
> >> Adding some mdelay to the remove function doesnt help either.
> > 
> > Tried not calling the pmac feature stuff at all in the rmmod ?
> 
> Olaf?

The pismo usually locks up after the fist rmmod. With a few delays
around the feature calls, a few more modprobe/rmmod cycles are possible.
But it still locks up after a while.
