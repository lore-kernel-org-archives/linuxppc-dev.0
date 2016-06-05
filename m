Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNCGX6ThFzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 08:31:00 +1000 (AEST)
Message-ID: <1465165853.4274.22.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: use _raw variant of page table accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Jun 2016 08:30:53 +1000
In-Reply-To: <7ba4cc59-351c-e990-97b4-c3429a0e7f34@gmail.com>
References: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <7ba4cc59-351c-e990-97b4-c3429a0e7f34@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-03 at 15:34 +1000, Balbir Singh wrote:
> 
> Can we just save the cpu_to_be64(_PAGE_PTE) as _BE64_PAGE_PTE constant
> in big-endian (pgtable-be-types.h) and similar for other things. I know its
> not the best option, but we don't really expect these bits to change often or anymore
> 
How does that help ? The compiler solves it at compile time either
way, I'm not sure adding yet another constant will improve
readability here.

Cheers,
Ben.
