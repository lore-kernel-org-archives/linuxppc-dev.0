Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id AD4F96891D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Dec 2005 06:06:40 +1100 (EST)
To: "Peter Fercher" <peter.fercher@scs.ch>
References: <004b01c6053a$5ec8ae50$dbe5fed4@scsad.scs.ch>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 26 Dec 2005 11:06:30 -0800
In-Reply-To: <004b01c6053a$5ec8ae50$dbe5fed4@scsad.scs.ch> (Peter Fercher's
	message of "Tue, 20 Dec 2005 08:52:48 +0100")
Message-ID: <adar77zekzt.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: Re: ppc440 EBC question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Peter> does somebody have a hint where to find an example how to
    Peter> talk to devices attached to the ppc440 external bus
    Peter> controller

I don't know of public example code but in general it is pretty easy.
Just set up the EBC registers to map your device into some unused
address space, and then use ioremap() and friends to access the bus.

 - R.
