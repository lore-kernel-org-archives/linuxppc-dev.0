Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87B7067B54
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 07:19:43 +1000 (EST)
Subject: Re: [PATCH] Make snd-aoa cope with lack of line-output-detect property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152537082.30697.37.camel@localhost>
References: <17586.19091.512322.908434@cargo.ozlabs.ibm.com>
	<1152537082.30697.37.camel@localhost>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:19:35 +1000
Message-Id: <1152566375.1576.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-10 at 15:11 +0200, Johannes Berg wrote:
> On Mon, 2006-07-10 at 22:39 +1000, Paul Mackerras wrote:
> > The snd-aoa stuff falls over on my G4 powerbook (1.5GHz Albook) with a
> > null pointer dereference in of_find_property.  It turns out that this
> > was because it couldn't find a device node for the line-output detect
> > GPIO.  This patch fixes it.
> 
> That's interesting. I thought I was running this code. Hmm :>

Slightly different model I suppose, 5,4 vs. 5,6 no ? Paul, can you send
Johannes a dumb of your device-tree ?

> I should probably drop the get_irq function completely and do that in
> line. And yes, that should be NO_IRQ I guess. I'll prepare a patch
> later.

Ben.
