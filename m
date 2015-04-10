Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C59BF1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 11:29:04 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0146.outbound.protection.outlook.com [157.56.110.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ACCE414012F
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 11:29:02 +1000 (AEST)
Message-ID: <1428629330.22867.567.camel@freescale.com>
Subject: Re: [PATCH v3 16/19] powerpc: fsl_pci, swiotlb: Move controller ops
 from ppc_md to controller_ops
From: Scott Wood <scottwood@freescale.com>
To: Daniel Axtens <dja@axtens.net>
Date: Thu, 9 Apr 2015 20:28:50 -0500
In-Reply-To: <1428624718-13564-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-17-git-send-email-dja@axtens.net>
 <1428624718-13564-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 10:11 +1000, Daniel Axtens wrote:
> Moves the setup out of swiotlb's subsys init call, and into an new
> structure.

"a new"

> fsl_pci.c is the only thing that checks the ppc_swiotlb_enable global,
> so we can be confident that patching it will cover all the PCI
> implementations affected by the changes to dma-swiotlb.c.

Do you mean the only thing that sets ppc_swiotlb_enable (fsl_pci.c
doesn't check it)?  It's also set by swiotlb_detect_4g().

Where is the rest of this patchset?  What is the problem being solved?

-Scott
