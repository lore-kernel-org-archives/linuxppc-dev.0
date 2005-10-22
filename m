Return-Path: <maz@misterjones.org>
Received: from young-lust.wild-wind.fr.eu.org (lopsy-lu.misterjones.org
	[62.4.18.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B91D868634
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 18:44:13 +1000 (EST)
From: Marc Zyngier <maz@misterjones.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
	<1129869509.6265.32.camel@gaston>
	<wrpek6eeo94.fsf@wild-wind.fr.eu.org>
	<1129934528.7919.15.camel@gaston>
Date: Sat, 22 Oct 2005 10:44:03 +0200
Message-ID: <wrpoe5ij60c.fsf@wild-wind.fr.eu.org>
In-Reply-To: <1129934528.7919.15.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sat, 22 Oct 2005 08:42:08 +1000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
Reply-To: maz@misterjones.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "BenH" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

BenH> Hrm... another thing you can do is have a look at the
BenH> init_bandit() routine. It does:

[...]

BenH> What is the value of "magic" in both cases ?

It says 0x17 in both case...

BenH> As for the rest, well, printing out the various addresses where
BenH> the kernel is copied and/or decompresses itself may help...

Will try that next. I also started diving into quik sources...

One more data point : kernel loaded with quik works just fine on a
7500 with a 604e@200 CPU. So it looks like it is some particular
firmware/hardware combinaison that triggers this failure mode.

BenH> Have you tried also netbooting directly vmlinux.coff ? (boot
BenH> enet: might work on OldWorld OF, you'll need a bootp server)
BenH> That works with some oldworlds, not all, depends if they have a
BenH> working ethernet driver in OF.

Nope. The poor thing doesn't even have an integrated ethernet to start
with (nor its official Apple counterpart)...

Stay tuned ;-)

	M.
-- 
And if you don't know where you're going, any road will take you there...
