Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 664BF1A10A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 11:19:27 +1000 (AEST)
Date: Wed, 27 May 2015 20:19:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Brian Norris <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>
CC: <linuxppc-dev@lists.ozlabs.org>, Jaiprakash Singh <b44839@freescale.com>
Subject: Re: [v5,RESEND] IFC: Change IO accessor based on endianness
Message-ID: <20150528011910.GA16716@home.buserror.net>
References: <1432174631-30091-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1432174631-30091-1-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 09:17:11PM -0500, Scott Wood wrote:
> From: Jaiprakash Singh <b44839@freescale.com>
> 
> IFC IO accressor are set at run time based
> on IFC IP registers endianness.IFC node in
> DTS file contains information about
> endianness.
> 
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v5: I'm assuming it's the same as v4, but I didn't send v4, and this
> comes from a versionless [RESEND] that never made it to the mailing list,
> so bumping the version just in case.
> 
>  .../bindings/memory-controllers/fsl/ifc.txt        |   3 +
>  drivers/memory/fsl_ifc.c                           |  43 ++--
>  drivers/mtd/nand/fsl_ifc_nand.c                    | 258 +++++++++++----------
>  include/linux/fsl_ifc.h                            |  50 ++++
>  4 files changed, 213 insertions(+), 141 deletions(-)

Brian, can I get an ack for this?

-Scott
