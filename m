Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A7F42C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2013 12:20:44 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: RE: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
Date: Sun, 28 Apr 2013 02:20:37 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C4C8EE@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
 <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
 <1366909096.30341.3@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C4C76D@039-SN1MPN1-002.039d.mgd.msft.net>
 <C8615FAE-3DFA-4086-88AE-2EA9EA700D15@kernel.crashing.org>
In-Reply-To: <C8615FAE-3DFA-4086-88AE-2EA9EA700D15@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]
> Sent: Saturday, April 27, 2013 9:32 PM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org
> Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to
> fix PCIe erratum on mpc85xx
>=20
> > In former email you doubt whether we need A variant or not.
> > Any particular reason for that?
> > If not should I emulate all the A ARX AU AUX and AX variant?
>=20
> A/AU/AX/AUX are just normal loads, sign-extended instead of zero-extended
> (so assign -1 to the register loaded).
>=20
> The ARX thing is load-locked, you do not want that one.
>=20
>=20
> Segher

Thanks, very helpful.
-Hongtao
