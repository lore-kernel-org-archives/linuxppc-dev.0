Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F65A2C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 12:26:39 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Segher Boessenkool
 <segher@kernel.crashing.org>
Subject: RE: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
Date: Sat, 27 Apr 2013 02:26:26 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C4C76D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
 <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
 <1366909096.30341.3@snotra>
In-Reply-To: <1366909096.30341.3@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> Sent: Friday, April 26, 2013 12:58 AM
> To: Segher Boessenkool
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Wood Scott-B07421
> Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to
> fix PCIe erratum on mpc85xx
>=20
> On 04/25/2013 10:31:51 AM, Segher Boessenkool wrote:
> >> * Remove A variant of load instruction emulation
> >
> > Why is this?  You handle all other simple load insns, there is nothing
> > special about LHA.  (I reviewed the V4 email thread, no reason for the
> > chance is given there).
>=20
> The LHA implementation in V5 was incorrect (didn't sign-extend).
>=20
> -Scott

In former email you doubt whether we need A variant or not.
Any particular reason for that?
If not should I emulate all the A ARX AU AUX and AX variant?

Thanks.
-Hongtao.
