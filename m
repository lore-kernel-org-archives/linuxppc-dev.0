Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BB821DDF9F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:48:05 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Date: Wed, 9 Jan 2008 15:42:38 +0100
References: <1199489214.9673.18.camel@basalt>
	<200801091216.25581.matthias.fuchs@esd-electronics.com>
	<20080109060723.06885abd@zod.rchland.ibm.com>
In-Reply-To: <20080109060723.06885abd@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091542.38914.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 January 2008 13:07, Josh Boyer wrote:
> On Wed, 9 Jan 2008 12:16:25 +0100
> Matthias Fuchs <matthias.fuchs@esd-electronics.com> wrote:
> 
> > Josh, 
> > 
> > Where did you apply this patch to? Couldn't find it in your for-2.6.25 branch.
> 
> I applied it there, just haven't pushed it out yet.  Will do that today.
> 
> > BTW, is it normal to edit the defconfig file by hand?
> 
> The defconfig?  Not sure.  What I normally do is a make foo_defconfig,
> edit the .config, make oldconfig, and copy the resulting .config back
> to foo_defconfig.
Yes, this is what I also do.

But how did Hollis get these lines into .config or sequoia_defconfig:

+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=128
+CONFIG_IBM_NEW_EMAC_TXB=64
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0

I did not find any Kconfigs where these might come from.

Any hint?

Matthias
