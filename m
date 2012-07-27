Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B09A2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 12:57:10 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V3 2/5] powerpc/fsl-pci: Determine primary bus by
 looking for ISA node
Date: Fri, 27 Jul 2012 02:56:57 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A286A3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <1343305827-26734-2-git-send-email-B38951@freescale.com>
 <C853F286-EB9D-4A73-936F-E56AA003396C@kernel.crashing.org>
In-Reply-To: <C853F286-EB9D-4A73-936F-E56AA003396C@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
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

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, July 27, 2012 2:22 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V3 2/5] powerpc/fsl-pci: Determine primary bus by
> looking for ISA node
>=20
>=20
> On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:
>=20
> > PCI host bridge is primary bus if it contains an ISA node. But not all
> boards
> > fit this rule. Device tree should be updated for all these boards.
>=20
> I don't really seen any reason for this patch.  We can just use the code
> as Scott wrote it that sets fsl_pci_primary based on search for the isa
> node.
>=20


I change the way of searching ISA node just because the platform driver
mechanism. Probe function of this driver will be called for each PCI
controller which means more than once. I think the Scott's way is not
perfectly match this situation. Anyway I will find a better way to solve
this by refactoring the Scott's method or using my own way.

Thanks.
-Hongtao.
