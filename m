Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 37AAEDDFAA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:59:48 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Thu, 10 Apr 2008 13:59:31 +0200
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<200804101221.43154.sr@denx.de> <1207823735.6958.7.camel@pasglop>
In-Reply-To: <1207823735.6958.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804101359.32095.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-04-10 at 12:21 +0200, Stefan Roese wrote:
> > Sure, this would be optimal. But frankly, I currently have no need for
> > this
> > non U-Boot mode, and therefore I didn't implement it. This can be
> > added later
> > when really needed don't you think?
>
> It can... but on the other hand, it's not hard :-)

But it takes time. And time is as always short. :)

> > Good. But again, I would really prefer to first include this U-Boot
> > style
> > endpoint support and later add this independent device tree endpoint
> > configuration when really needed.
>
> Well, you are the one with a use case... but I do think we should
> differenciate a PCI in host mode vs. endpoint mode right away. We don't
> want the PCI stack from kicking in at all in endpoint mode, we don't
> want to bother with creating the PCI infrastructure and config space
> accessors etc...

Understood. But for this "dynamic" root-complex/endpoint configuration as 
implemented with the current version of the patch, I can't change the PCIe 
node in the dts from root-complex mode to endpoint mode, since I would loose 
root-complex functionality. Perhaps I'm missing something here.

Best regards,
Stefan
