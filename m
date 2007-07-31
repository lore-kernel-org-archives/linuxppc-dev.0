Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3189DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 07:44:41 +1000 (EST)
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <f55fea27ac3a248cc99d52462d413e1e@kernel.crashing.org>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<f55fea27ac3a248cc99d52462d413e1e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 07:44:27 +1000
Message-Id: <1185918267.5495.505.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-31 at 21:42 +0200, Segher Boessenkool wrote:
> > Which makes me think (again) that we should have an optional 
> > device_node
> > pointer in irq_host. I know you said you wanted the irq stuff to be OF
> > agnostic, but the reality is most of the implementations do have an OF
> > node. And all of the newer irq_host implementations do, with the
> > exception of PS3 and celleb - which are special.
> 
> How do you suggest to get a reasonable display name out of
> the device tree?  The recommended human-readable name for
> interrupt controller nodes is "interrupt-controller"...
> You cannot use "device_type" either, and using "compatible"
> requires selecting one of its string entries, and likely
> using a lookup table after that, too.

In that case, I would display the node full path.

Ben.
