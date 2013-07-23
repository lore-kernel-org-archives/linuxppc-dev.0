Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC8662C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 11:58:44 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/msi: Fix compile error on mpc83xx
Date: Tue, 23 Jul 2013 01:58:36 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01CF8A4D@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1372728997-31665-1-git-send-email-hongtao.jia@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01CF350E@039-SN1MPN1-004.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01CF8676@039-SN1MPN1-004.039d.mgd.msft.net>
 <1374513533.15592.3@snotra>
In-Reply-To: <1374513533.15592.3@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 23, 2013 1:19 AM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Li Yang-R58472; Jia Hongtao-B38951
> Subject: Re: [PATCH] powerpc/msi: Fix compile error on mpc83xx
>=20
> On 07/21/2013 09:00:51 PM, Jia Hongtao-B38951 wrote:
> > Hi Scott,
> >
> > The fsl_msi.c build error on MPC83xx platform is fixed by this patch.
> >
> > Could you please have a review?
> >
> > Thanks.
> > -Hongtao
>=20
> I will apply it when I apply the patch that depends on it.  I hope to
> resume applying patches soon.
>=20
> -Scott

Thanks.
- Hongtao
