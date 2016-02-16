Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB6361A0353
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:00:21 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 09:00:21 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BD9F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:00:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GN0AbG61538362
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:00:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GMxjxN027973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:59:45 +1100
Date: Wed, 17 Feb 2016 09:59:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: rename EEH from "extended" to "enhanced"
 error handling
Message-ID: <20160216225921.GA8768@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455624365-4200-1-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455624365-4200-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 11:06:05PM +1100, Russell Currey wrote:
>IBM online documentation for EEH uses "extended error handling" and
>"enhanced error handling" to refer to the same thing, in different
>places.  The only place mentioning it as "enhanced error handling" in the
>kernel is the MAINTAINERS file, and it's "extended" in some documentation.
>
>IBM originally defined EEH as "enhanced error handling", so standardise
>all mentions of EEH to use that term.
>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
>This is essentially a V2 (though it has the inverse result) of this patch:
>https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-February/139367.html
>---
> Documentation/powerpc/eeh-pci-error-recovery.txt | 2 +-
> arch/powerpc/kernel/eeh.c                        | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
>index 9d4e33d..6781892 100644
>--- a/Documentation/powerpc/eeh-pci-error-recovery.txt
>+++ b/Documentation/powerpc/eeh-pci-error-recovery.txt
>@@ -12,7 +12,7 @@ Overview:
> The IBM POWER-based pSeries and iSeries computers include PCI bus
> controller chips that have extended capabilities for detecting and
> reporting a large variety of PCI bus error conditions.  These features
>-go under the name of "EEH", for "Extended Error Handling".  The EEH
>+go under the name of "EEH", for "Enhanced Error Handling".  The EEH
> hardware features allow PCI bus errors to be cleared and a PCI
> card to be "rebooted", without also having to reboot the operating
> system.
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 40e4d4a..2e78466 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -48,7 +48,7 @@
> 
> 
> /** Overview:
>- *  EEH, or "Extended Error Handling" is a PCI bridge technology for
>+ *  EEH, or "Enhanced Error Handling" is a PCI bridge technology for
>  *  dealing with PCI bus errors that can't be dealt with within the
>  *  usual PCI framework, except by check-stopping the CPU.  Systems
>  *  that are designed for high-availability/reliability cannot afford
>-- 
>2.7.1
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
