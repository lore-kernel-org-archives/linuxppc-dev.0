Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 54F1BB6FEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 12:11:02 +1100 (EST)
Message-ID: <4F0B901C.6020100@freescale.com>
Date: Mon, 9 Jan 2012 19:10:52 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [PATCH 2/2][v2] mtd/nand: Fix IFC driver to support 2K NAND page
References: <1326111866-13120-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1326111866-13120-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 06:24 AM, Prabhakar Kushwaha wrote:
> 1) OOB area should be updated irrespective of NAND page size. Earlier it was
> updated only for 512byte NAND page.
> 
> 2) During OOB update fbcr should be equal to OOB size.
> 
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)
> 
>  This patch is created on top of IFC driver patch (already floated in mailing
>  list). Please find their link:
>  http://patchwork.ozlabs.org/patch/133315/
>  http://patchwork.ozlabs.org/patch/133316/

Looks good.

-Scott
