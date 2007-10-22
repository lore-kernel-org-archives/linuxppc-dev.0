Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E446BDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 14:52:36 +1000 (EST)
Subject: Re: ppc manual paging question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
In-Reply-To: <200710221203.24157.wangbj@lzu.edu.cn>
References: <200710221203.24157.wangbj@lzu.edu.cn>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 14:50:52 +1000
Message-Id: <1193028652.6745.57.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Miguel Masmano <mimastel@doctor.upv.es>, linux-embedded@opentech.lzu.edu.cn
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-22 at 12:03 +0800, Wang, Baojun wrote:
> hi,
> 
>   I've got some qeustion about ppc(ppc44x) paging: 
> 
> how can I manually map a virtual address to a physical address through a 
> specific pgd? How does ppc translate virt address to physical one? I think 
> besides from tlb, the CPU will search the page table entries via the pgd, can 
> I alter the pgd value to change the memory translation? under i386, it's very 
> simple, we can just rewrite %%cr3, it even could invalidate all tlb entries 
> automatically, how can I do this under ppc? I've tried rewrite 
> current->mm->pgd and current->thread.pgdir, but sounds like it still not 
> insufficiant, am I missing something vital? 

What the heck are you trying to do ? Please explain and I'll tell you
how to do it properly :-)

Cheers,
Ben.
