Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8CE7CB6FA5
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2011 01:15:56 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl_msi: add support for "msi-address-64" property
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1316799695-31376-1-git-send-email-timur@freescale.com>
Date: Fri, 14 Oct 2011 09:15:08 -0500
Message-ID: <C4D76656-C95E-4906-BC65-6EBAFBBB6A7C@freescale.com>
References: <1316799695-31376-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 23, 2011, at 12:41 PM, Timur Tabi wrote:

> Add support for the msi-address-64 property of a PCI node.  This =
property
> specifies the PCI address of MSIIR (message signaled interrupt index
> register).
>=20
> In commit 3da34aae ("powerpc/fsl: Support unique MSI addresses per =
PCIe Root
> Complex"), the msi_addr_hi/msi_addr_lo fields of struct fsl_msi were =
redefined
> from an actual address to just an offset, but the fields were not =
renamed
> accordingly.  These fields are replace with a single field, =
msiir_offset,
> to reflect the new meaning.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This patch is necessary, but not sufficient, for MSI support under the
> Freescale hypervisor.  Future patches will add full support.
>=20
> .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |   42 =
++++++++++++++++++++
> arch/powerpc/sysdev/fsl_msi.c                      |   20 +++++++---
> arch/powerpc/sysdev/fsl_msi.h                      |    3 +-
> 3 files changed, 57 insertions(+), 8 deletions(-)

applied

- k=
