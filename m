Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0B731A0076
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 09:26:58 +1100 (AEDT)
Message-ID: <1454365611.2486.18.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>
Cc: prabhakar.kushwaha@nxp.com, Jaiprakash Singh <b44839@freescale.com>
Date: Mon, 01 Feb 2016 16:26:51 -0600
In-Reply-To: <1454323598-5149-3-git-send-email-raghav@freescale.com>
References: <1454323598-5149-1-git-send-email-raghav@freescale.com>
 <1454323598-5149-3-git-send-email-raghav@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] mtd/ifc: Segregate IFC fcm and runtime registers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-01 at 16:16 +0530, Raghav Dogra wrote:
>  /*
>   * IFC Controller Registers
>   */
> -struct fsl_ifc_regs {
> +struct fsl_ifc_fcm {
>  	__be32 ifc_rev;
>  	u32 res1[0x2];
>  	struct {

This struct is not specific to fcm (i.e. nand).  Please choose a better name,
such as fsl_ifc_global (which would match "gregs").

-Scott
