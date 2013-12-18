Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B05732C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:49:03 +1100 (EST)
Message-ID: <1387338529.3140.42.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 7/8] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:48:49 -0600
In-Reply-To: <1373357007-30785-8-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-8-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> Book3e is always aligned 1GB to create TLB so we should
> use (KERNELBASE - MEMORY_START) as VIRT_PHYS_OFFSET to
> get __pa/__va properly while boot kdump.

What if MEMORY_START - PHYSICAL_START >= 1 GiB?

What about the comment that says we can't use MEMORY_START before
parsing the device tree?

-Scott
