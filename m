Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKJxC0mDdzDqbm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 15:35:59 +1000 (AEST)
Date: Wed, 1 Jun 2016 15:35:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] powerpc: Avoid load hit store when using
 find_linux_pte_or_hugepte()
Message-ID: <20160601153540.110f221d@kryten>
In-Reply-To: <3rKGRg1Mkbz9t6g@ozlabs.org>
References: <1464523432-12605-3-git-send-email-anton@ozlabs.org>
 <3rKGRg1Mkbz9t6g@ozlabs.org>
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

Hi Michael,

> I'd really rather __find_linux_pte_or_hugepte() was an internal
> detail, rather than the standard API.
> 
> We do already have quite a few uses, but adding more just further
> spreads the details about how the implementation works.
> 
> So I'm going to drop this in favor of Aneesh's patch to make irqs
> disabled check a VM_WARN().

Makes sense, I agree.

Anton
