Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 893C9B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 14:07:00 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
 platform
Date: Thu, 28 Jun 2012 04:06:39 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A10EAB@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20120627234851.GA9071@tyr.buserror.net>
In-Reply-To: <20120627234851.GA9071@tyr.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>
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
> Sent: Thursday, June 28, 2012 7:49 AM
> To: galak@kernel.crashing.org
> Cc: agraf@suse.de; linuxppc-dev@lists.ozlabs.org; Jia Hongtao-B38951
> Subject: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
> platform
>=20
> The QEMU stuff is related to the PCI refactoring because currently
> we have a hard time selecting a primary bus under QEMU, and also because
> the generic qemu e500 platform wants a full list of FSL PCI compatibles
> to check.
>=20

It seems that not all primary bus has "isa" node like 8541 and 8555.

Without PM support for pci controllers I totally agree with this refactorin=
g
for pci init. But in linux mechanism PM ops should be registered to a drive=
r.
Do you have any ideas to add PM support for pci controllers under this patc=
hset?

Thanks.
-Jia Hongtao.
