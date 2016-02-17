Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14F651A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:35:46 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 08:35:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ED1E62BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:35:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HMZXP65636368
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:35:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HMZ9Jh006138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:35:09 +1100
Date: Thu, 18 Feb 2016 09:34:44 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] MAINTAINERS: Update EEH details and maintainership
Message-ID: <20160217223444.GA6112@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 05:06:04PM +1100, Russell Currey wrote:
>Enhanced Error Handling could mean anything in the context of the entire
>kernel, so change the name to reference that it is both for PCI and
>powerpc.
>
>EEH covers a bit more than the previously listed files, so add the headers
>and platform-specific code to the EEH maintained section.
>
>In addition, I am taking over the maintainership.
>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> MAINTAINERS | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 28eb61b..95d999e 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4222,13 +4222,6 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
> S:	Maintained
> F:	drivers/media/rc/ene_ir.*
>
>-ENHANCED ERROR HANDLING (EEH)
>-M:	Gavin Shan <shangw@linux.vnet.ibm.com>
>-L:	linuxppc-dev@lists.ozlabs.org
>-S:	Supported
>-F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>-F:	arch/powerpc/kernel/eeh*.c
>-
> EPSON S1D13XXX FRAMEBUFFER DRIVER
> M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
> S:	Maintained
>@@ -8244,6 +8237,15 @@ L:	linux-pci@vger.kernel.org
> S:	Supported
> F:	Documentation/PCI/pci-error-recovery.txt
>
>+PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>+M:	Russell Currey <ruscur@russell.cc>
>+L:	linuxppc-dev@lists.ozlabs.org
>+S:	Supported
>+F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>+F:	arch/powerpc/kernel/eeh*.c
>+F:	arch/powerpc/platforms/*/eeh*.c
>+F:	arch/powerpc/include/*/eeh*.h
>+
> PCI SUBSYSTEM
> M:	Bjorn Helgaas <bhelgaas@google.com>
> L:	linux-pci@vger.kernel.org
>-- 
>2.7.1
>
