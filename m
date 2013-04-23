Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BF802C0152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 16:36:39 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH 1/2] powerpc: Move opcode definitions from kvm/emulate.c
 to asm/ppc-opcode.h
Date: Tue, 23 Apr 2013 06:36:31 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C4A4B0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <20130423052951.GB20902@concordia>
In-Reply-To: <20130423052951.GB20902@concordia>
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
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Michael
> Ellerman
> Sent: Tuesday, April 23, 2013 1:30 PM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/2] powerpc: Move opcode definitions from
> kvm/emulate.c to asm/ppc-opcode.h
>=20
> On Tue, Apr 23, 2013 at 10:39:35AM +0800, Jia Hongtao wrote:
> > Opcode and xopcode are useful definitions not just for KVM. Move these
> > definitions to asm/ppc-opcode.h for public use.
>=20
> Agreed. Though nearly everything else in ppc-opcode.h uses PPC_INST_FOO,
> or at least PPC_FOO, any reason not to update these to match?
>=20
> cheers

These definitions are firstly used by KVM defined like OP_31_XOP_TRAP.
Two ways to extract these definitions for public use:

1. Like this patch did. For keeping the KVM code that using these
   definitions unchanged we do not update them to match.

2. Move these definitions to another .h file like my last patch did:
   http://patchwork.ozlabs.org/patch/235646/
   You can see the comments there.

Thanks.
-Hongtao
