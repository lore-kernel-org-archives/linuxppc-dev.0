Return-Path: <tie-fei.zang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 567992C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:53:43 +1100 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH][v2] powerpc/pci: Fix IMMRBAR address
Date: Mon, 20 Jan 2014 15:39:00 +0000
Message-ID: <18efa785a18e4944af7cb6822b3b36ee@BLUPR03MB165.namprd03.prod.outlook.com>
References: <1390215260-28888-1-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1390215260-28888-1-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Minghuan Lian [mailto:Minghuan.Lian@freescale.com]
> Sent: Monday, January 20, 2014 4:54 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Zang Roy-R61911; Wood Scott-B07421; Kumar Gala; Lian Minghuan-B31939
> Subject: [PATCH][v2] powerpc/pci: Fix IMMRBAR address
>=20
> For PEXCSRBAR, bit 3-0 indicate prefetchable and address type.
> So when getting base address, these bits should be masked,
> otherwise we may get incorrect base address.
>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Acked.
Roy
