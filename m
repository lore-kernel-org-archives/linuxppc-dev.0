Return-Path: <r58472@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 705A3B71CE
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2011 16:16:01 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Liu Shuo-B35362 <B35362@freescale.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>
Subject: RE: [PATCH v2] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
Date: Wed, 3 Aug 2011 06:15:56 +0000
Message-ID: <3F607A5180246847A760FD34122A1E051BC8DF@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310446122-18050-1-git-send-email-b35362@freescale.com>
In-Reply-To: <1310446122-18050-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message-----
>From: Liu Shuo-B35362
>Sent: Tuesday, July 12, 2011 12:49 PM
>To: dwmw2@infradead.org
>Cc: linux-mtd@lists.infradead.org; linuxppc-dev@ozlabs.org; Liu Shuo-
>B35362; Li Yang-R58472
>Subject: [PATCH v2] mtd/nand : workaround for Freescale FCM to support
>large-page Nand chip
>
>From: Liu Shuo <b35362@freescale.com>
>
>Freescale FCM controller has a 2K size limitation of buffer RAM. In order
>to support the Nand flash chip whose page size is larger than 2K bytes, we
>divide a page into multi-2K pages for MTD layer driver. In that case, we
>force to set the page size to 2K bytes. We convert the page address of MTD
>layer driver to a real page address in flash chips and a column index in
>fsl_elbc driver. We can issue any column address by UA instruction of elbc
>controller.
>
>Signed-off-by: Liu Shuo <b35362@freescale.com>
>Signed-off-by: Li Yang <leoli@freescale.com>
>---

Hi David and Artem,

We have fixed the multi-line comment style problem.  Could you help to pick=
 the patch?

- Leo
