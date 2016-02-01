Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF70B1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 06:41:50 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id l66so10585723wml.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2016 11:41:50 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1454323598-5149-3-git-send-email-raghav@freescale.com>
References: <1454323598-5149-1-git-send-email-raghav@freescale.com>
 <1454323598-5149-3-git-send-email-raghav@freescale.com>
Date: Mon, 1 Feb 2016 13:41:45 -0600
Message-ID: <CADRPPNThvUNOtN=2PErWVfhKz_xqBmps+HyL8GTo8+D_-eKX4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd/ifc: Segregate IFC fcm and runtime registers
From: Li Yang <leoli@freescale.com>
To: Raghav Dogra <raghav@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, oss@buserror.net,
 prabhakar.kushwaha@nxp.com, Jaiprakash Singh <b44839@freescale.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 1, 2016 at 4:46 AM, Raghav Dogra <raghav@freescale.com> wrote:

A general comment is that you should include the linux-mtd mailing
list and it's maintainers for this set of patches.  Although the
MAINTAINERS file doesn't specify a maintainer for drivers/memory
directory, it should be most related to linux-mtd, IMO.

> IFC has two set of registers viz FCM (Flash control machine)
> aka global and run time registers. These set are defined in two
> memory map PAGES. Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0
> PAGE size is 64KB

So I guess this patch is the critical change to make the fsl_ifc
driver work with the version 2.0 hardware block?  If so, it will be
better to mention this in the patch title.

>
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
>  drivers/memory/fsl_ifc.c        | 251 +++++++++++++++++++++-------------------
>  drivers/mtd/nand/fsl_ifc_nand.c |  72 ++++++------
>  include/linux/fsl_ifc.h         |  48 +++++---
>  3 files changed, 203 insertions(+), 168 deletions(-)

Regards,
Leo
