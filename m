Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D7D7ADDE48
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 23:38:33 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Date: Sat, 5 Jan 2008 13:38:17 +0100
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<1199528388.7291.55.camel@pasglop>
In-Reply-To: <1199528388.7291.55.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801051338.17957.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
> On Sat, 2008-01-05 at 10:50 +0100, Stefan Roese wrote:
> > Performance tests done by AMCC have shown that 256 buffer increase the
> > performance of the Linux EMAC driver. So let's update the default
> > values to match this setup.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
>
> Do we have the numbers ? Did they also measure latency ?

I hoped this question would not come. ;) No, unfortunately I don't have any 
numbers. Just the recommendation from AMCC to always use 256 buffers.

Best regards,
Stefan
