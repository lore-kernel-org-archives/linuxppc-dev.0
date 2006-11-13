Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id 5A73D67ED7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 06:08:20 +1100 (EST)
Message-ID: <4558C2A1.7080402@s5r6.in-berlin.de>
Date: Mon, 13 Nov 2006 20:08:17 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
	<20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<20061113175808.GA15565@aepfle.de>
In-Reply-To: <20061113175808.GA15565@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Cc: Gioele Barabucci <dev@gioelebarabucci.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
>> On  7 Nov, Benjamin Herrenschmidt wrote:
>> > Tried not calling the pmac feature stuff at all in the rmmod ?

> The pismo usually locks up after the fist rmmod. With a few delays
> around the feature calls, a few more modprobe/rmmod cycles are possible.
> But it still locks up after a while.

But what if you delete the feature calls from ohci1394_pci_remove?
-- 
Stefan Richter
-=====-=-==- =-== -==-=
http://arcgraph.de/sr/
