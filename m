Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBn23k3wzDsb5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:47:18 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 21so2061319pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:47:18 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:47:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/13] powerpc: Add support to mask perf interrupts and
 replay them
Message-ID: <20160916204708.0ef42ef3@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-12-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-12-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Sep 2016 18:32:01 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> To support masking of the PMI interrupts, couple of new interrupt handler
> macros are added MASKABLE_EXCEPTION_PSERIES_OOL and
> MASKABLE_RELON_EXCEPTION_PSERIES_OOL.
> 
> Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added to
> use in the exception code to check for PMI interrupts.
> 
> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
> and return. In the __check_irq_replay(), replay the PMI interrupt
> by calling performance_monitor_common handler.


Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
