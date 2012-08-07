Return-Path: <r61911@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 887852C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 13:45:52 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
Date: Tue, 7 Aug 2012 03:45:30 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
 <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shengzhou-B36685 <B36685@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Liu Shengzhou-B36=
685
> Sent: Thursday, July 26, 2012 11:45 AM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; akpm@linux-
> foundation.org
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B3668=
5
> Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable n=
on
> MSI/INTx interrupt
>=20
> Hello,
>=20
> A gentle reminder!
> Any comments are appreciated.

Who can help to review and pick up this patch?
Thanks.
Roy
