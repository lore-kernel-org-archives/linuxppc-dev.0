Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 719B1DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 22:00:46 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Thu, 7 Jun 2007 14:00:32 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706071010.05172.jdubois@mc.com>
	<1181217341.14818.48.camel@localhost.localdomain>
In-Reply-To: <1181217341.14818.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706071400.32844.jdubois@mc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007 13:55:41 Benjamin Herrenschmidt wrote:
> On Thu, 2007-06-07 at 10:10 +0200, Jean-Christophe Dubois wrote:
> > The CAB (or other derived products) can be set in RC mode (via a jumper).
> > In this case the MSI could be supported.
>
> Is there any plan to have CABs based on AXON DD >= 2.0

Sure, There are several at Mercury (based on Axon 2.1) and I have one. And I 
believe it will be based on Axon 3.0 when available.

> I still think the right approach is to have the right properties set by
> the firmware if the Axon version supports MSIs reliably. Do you see any
> problem with this approach ?

Once again SLOF firmware is out of my influence realm. I work with what IBM is 
delivering for CAB ... So if the firmware has some deficiencies I must make 
sure we can work around them.

JC

> Ben.
