Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416hYX0vL0zF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 23:44:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: vrbagal1 <vrbagal1@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, aneesh.kumar@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [powerpc/powervmc]kernel BUG at
 arch/powerpc/mm/pgtable-book3s64.c:414!
In-Reply-To: <4ca83e8bdd7d9f573a51837fc66a2c45@linux.vnet.ibm.com>
References: <4ca83e8bdd7d9f573a51837fc66a2c45@linux.vnet.ibm.com>
Date: Fri, 15 Jun 2018 23:44:28 +1000
Message-ID: <87h8m49nb7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vrbagal1 <vrbagal1@linux.vnet.ibm.com> writes:

> Hi,
>
> Observing kernel bug followed by kernel oops and system reboots, while 
> running kselftest on Power8 LPAR.
>
> Machine Details: Power8 LPAR
> Git Tree: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Commit ID: f5b7769eb0400ec5217a47e41148a9f816ca1f9f
> Kernel version: 4.17.0-autotest
> GCC version: (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC))
>

This is fixed by your patch Aneesh?

http://patchwork.ozlabs.org/patch/929325/

cheers
