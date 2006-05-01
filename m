Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 807E567B49
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 17:16:16 +1000 (EST)
Subject: Re: windfarm for PM72/PM73/RM31
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
In-Reply-To: <20060501064443.GA20481@curie-int.vc.shawcable.net>
References: <20060501002719.GD15141@curie-int.vc.shawcable.net>
	<A2D81A03-8CD5-41CD-BD49-3EDB1CDE53FD@laposte.net>
	<20060501064443.GA20481@curie-int.vc.shawcable.net>
Content-Type: text/plain
Date: Mon, 01 May 2006 17:16:05 +1000
Message-Id: <1146467765.30710.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-04-30 at 23:44 -0700, Robin H. Johnson wrote:
> On Mon, May 01, 2006 at 06:53:09AM +0200, ?tienne Bersac wrote:
> > I own an iMac G5 rev C (iSight) with a PowerMac 12,1 included. Do you  
> > intend to make support for it ? I will be happy to help you :)
> I'd like to start on the PM72 stuff first, but please tar up your
> /proc/device-tree/ directory and email it to me, and I can see about it.
> 
> If Apple stuck to the same sensors (max6690, lm75. lm87, ds1775, ds1631,
> ad7417), it should be reasonable simple to add your machine afterwards.
> 
> Is there actually a reasonable archive of the OF node trees somewhere?
> It think it might be handy in developing drivers in future. I've
> presently got: PowerBook4,3 PowerMac7,2 PowerMac7,3 PowerMac11,2

I'm not sure we can publically post them, there might be some apple
copyright lurking around. I have a fairly big archive here too.

Ben.
