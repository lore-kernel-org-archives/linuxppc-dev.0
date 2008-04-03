Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E0A03DDFBC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 23:35:56 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Add support for 460EX/GT-type MAL rx-channel
	handling
Date: Thu, 3 Apr 2008 14:35:39 +0200
References: <1207223110-27281-1-git-send-email-sr@denx.de>
	<1207225740.10388.321.camel@pasglop>
In-Reply-To: <1207225740.10388.321.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804031435.39999.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-04-03 at 13:45 +0200, Stefan Roese wrote:
> > On some 4xx PPC's (e.g. 460EX/GT), the rx channel number is a multiple
> > of 8 (e.g. 8 for EMAC1, 16 for EMAC2), but enabling in MAL_RXCASR needs
> > the divided by 8 value for the bitmask.
>
> Sounds ok, but I wonder if we ever have a MAL with more than 8 chans, do
> we need to make this shift conditional to some device tree prop ?

I suggest we postpone such a conditional setup until we see such a MAL. OK?

Best regards,
Stefan
