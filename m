Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97B46DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 05:42:59 +1000 (EST)
In-Reply-To: <1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f55fea27ac3a248cc99d52462d413e1e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
Date: Tue, 31 Jul 2007 21:42:38 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Which makes me think (again) that we should have an optional 
> device_node
> pointer in irq_host. I know you said you wanted the irq stuff to be OF
> agnostic, but the reality is most of the implementations do have an OF
> node. And all of the newer irq_host implementations do, with the
> exception of PS3 and celleb - which are special.

How do you suggest to get a reasonable display name out of
the device tree?  The recommended human-readable name for
interrupt controller nodes is "interrupt-controller"...
You cannot use "device_type" either, and using "compatible"
requires selecting one of its string entries, and likely
using a lookup table after that, too.


Segher
