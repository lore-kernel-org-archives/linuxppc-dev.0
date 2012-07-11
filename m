Return-Path: <Kolja.Schneider@men.de>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.130])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta5.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB0E82C0219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 00:52:48 +1000 (EST)
From: "Schneider, Kolja" <Kolja.Schneider@men.de>
To: Timur Tabi <b04825@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
Subject: AW: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Date: Wed, 11 Jul 2012 14:52:33 +0000
Message-ID: <D42F060B3778074EA85B5FC2CC9E015C449536C4@MEN-EX2.intra.men.de>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
 <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
 <4FFD9281.1070202@freescale.com>
In-Reply-To: <4FFD9281.1070202@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Xu Jiucheng-B37781 <B37781@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Kumar Gala wrote:
> > Since we already have P1021RDB-PC w/AMP support in upstream I agree
> we don't need another example on P1021RDB-PC.
>=20
> Would you accept a patch that removes all AMP device trees from upstream?
>  I just don't think that these very customer-specific dts files belong
> upstream
[>]=20

Is there any alternate source for AMP device trees? Just in case someone
needs some sort of documentation?

:-) Kolja

.
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
