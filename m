Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23859B71BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Sep 2011 14:10:13 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: RE: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Tue, 13 Sep 2011 04:10:05 +0000
Message-ID: <2239AC579C7D3646A720227A37E026811A3C67@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	<20110909114004.GP1912@pengutronix.de>
	<2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
	<20110909123324.GQ1912@pengutronix.de>
	<2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
	<20110909130855.GR1912@pengutronix.de>
In-Reply-To: <20110909130855.GR1912@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"cjb@laptop.org" <cjb@laptop.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel=
.org]
> On Behalf Of Wolfram Sang
> Sent: Friday, September 09, 2011 21:09 PM
> To: Zang Roy-R61911
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.=
org;
> akpm@linux-foundation.org; cbouatmailru@gmail.com; Xu Lei-B33228; Kumar G=
ala
> Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
>=20
>=20
> > Previously, I sent this patch together  with another one. But
> > technically they are separated patches.  I got some comments from
> > Anton about the patch. I will try to address the comment. but for this
> > one, it is a stand along patch. I'd like to push it first.
>=20
> Okay.
Good.
>=20
> > I do not see any comment about byte swapping about this patch.
> > you may have mis-understanding here.
>=20
> I was misguided, yes, sorry. BE/LE issues with additional byteswapping
> are a mind twister :/ Having a second look, it looks okay to me. One
> could think about putting this into sdhci_platform as well, but this can
> be done later if needed. Sadly, I currently don't have hardware to test
> it.
I tested on 8536 and P4080/P5020/P3041 platform.
Anyone can help to pull it in?
Thanks.
Roy
