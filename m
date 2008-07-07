Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A697EDDED0
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:29:25 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH v5] ibm_newemac: Parameterize EMAC Multicast Match Handling
Date: Mon, 7 Jul 2008 08:29:17 +0200
References: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
	<200807070758.45828.sr@denx.de> <1215410405.8970.84.camel@pasglop>
In-Reply-To: <1215410405.8970.84.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807070829.17340.sr@denx.de>
Cc: Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Benjamin Herrenschmidt wrote:
> On Mon, 2008-07-07 at 07:58 +0200, Stefan Roese wrote:
> > On Monday 07 July 2008, Grant Erickson wrote:
> > > Various instances of the EMAC core have varying: 1) number of address
> > > match slots, 2) width of the registers for handling address match
> > > slots, 3) number of registers for handling address match slots and 4)
> > > base offset for those registers.
> >
> > <snip>
> >
> > > Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> >
> > Acked-by: Stefan Roese <sr@denx.de>
>
> Did you have a chance to do a bit of regression testing "just in case" ?

No, not yet. I'll try to do some tests this week.

Best regards,
Stefan
