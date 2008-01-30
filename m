Return-Path: <SRS0=8N4g=SU=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 38C4DDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 17:17:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Date: Wed, 30 Jan 2008 07:16:52 +0100
References: <1200476230-14026-1-git-send-email-sr@denx.de>
	<1200477239.6755.21.camel@pasglop>
	<20080116090110.1b7b2f00@zod.rchland.ibm.com>
In-Reply-To: <20080116090110.1b7b2f00@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801300716.52463.sr@denx.de>
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 January 2008, Josh Boyer wrote:
> On Wed, 16 Jan 2008 20:53:59 +1100
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Wed, 2008-01-16 at 10:37 +0100, Stefan Roese wrote:
> > > With the removal the the "rgmii-interface" device_type property from
> > > the dts files, the newemac driver needs an update to only rely on
> > > compatible property.
> > >
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> >
> > I need to test if it works on CAB, can't change the DT on those. I'll
> > let you know tomorrow.
>
> This should be fine on CAB.  The rgmii node has:
>
> compatible = "ibm,rgmii-axon", "ibm,rgmii"
>
> so the match should still catch on the latter.

How about this patch? Ben, if you think this is ok then we should make sure 
that it goes in in this merge-window, since the other dts patch relies on it.

Thanks.

Best regards,
Stefan
