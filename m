Return-Path: <roy.zang@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0077.outbound.protection.outlook.com [104.47.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srG9P4tkDzDrSL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 04:05:13 +1100 (AEDT)
From: Roy Zang <roy.zang@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Minghuan Lian
 <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>, "Roy
 Zang" <tie-fei.zang@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/7] PCI: layerscape: Name private struct pointer "ls"
 consistently
Date: Fri, 7 Oct 2016 17:05:05 +0000
Message-ID: <HE1PR0402MB27481312F256EBB295800F878BC60@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/07/2016 11:42 AM, Bjorn Helgaas wrote:=0A=
> Use a device-specific name, "ls", for struct ls_pcie pointers=0A=
> to hint that this is device-specific information.  No functional change=
=0A=
> intended.=0A=
how about ls_pcie  instead of ls ?=0A=
Roy=0A=
