Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A1BA679E2
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 09:53:54 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143637243.9481.17.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
	<1143604878.3585.5.camel@localhost.localdomain>
	<1143637243.9481.17.camel@localhost>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:53:39 +1100
Message-Id: <1143672819.32206.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-29 at 15:00 +0200, Johannes Berg wrote:
> On Wed, 2006-03-29 at 15:01 +1100, Benjamin Herrenschmidt wrote:
> > BTW.. with the current stuff, if I install the modules and then do
> > 
> > modprobe i2sbus
> > 
> > I get a registration error in dmesg. 
> 
> Hmm. What's the error? Can't reproduce this at all. Also, what machine?
> It works fine on my powermac, even when i2sbus is auto-loaded due to
> binding to the macio i2s device alias.

On the laptop.

Mar 29 11:11:51 localhost kernel: [  192.069735] i2sbus: found i2s
controller
Mar 29 11:11:51 localhost kernel: [  192.069752] soundbus: adding device
failed sanity check!
Mar 29 11:11:51 localhost kernel: [  192.069757] i2sbus: device
registration error!
