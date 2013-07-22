Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 814562C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 03:19:19 +1000 (EST)
Date: Mon, 22 Jul 2013 12:18:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/msi: Fix compile error on mpc83xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <1372728997-31665-1-git-send-email-hongtao.jia@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01CF350E@039-SN1MPN1-004.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01CF8676@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01CF8676@039-SN1MPN1-004.039d.mgd.msft.net>
 (from B38951@freescale.com on Sun Jul 21 21:00:51 2013)
Message-ID: <1374513533.15592.3@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2013 09:00:51 PM, Jia Hongtao-B38951 wrote:
> Hi Scott,
>=20
> The fsl_msi.c build error on MPC83xx platform is fixed by this patch.
>=20
> Could you please have a review?
>=20
> Thanks.
> -Hongtao

I will apply it when I apply the patch that depends on it.  I hope to =20
resume applying patches soon.

-Scott=
