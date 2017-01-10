Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyLnM4SbczDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 16:54:15 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y143so6085144pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 21:54:15 -0800 (PST)
Date: Tue, 10 Jan 2017 15:54:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 09/12] powerpc:Add new kconfig IRQ_DEBUG_SUPPORT
Message-ID: <20170110155402.2da6f9c9@roar.ozlabs.ibm.com>
In-Reply-To: <1483968978-16035-10-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483968978-16035-10-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon,  9 Jan 2017 19:06:15 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add warn_on
> to alert the invalid transitions. Also moved the code under
> the CONFIG_TRACE_IRQFLAGS in arch_local_irq_restore() to new Kconfig.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
