Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BAB45B704C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 05:52:21 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id CADA3179555C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 04:41:16 +0900 (JST)
Message-ID: <4FDB8FC9.2020909@jp.fujitsu.com>
Date: Fri, 15 Jun 2012 15:40:57 -0400
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
MIME-Version: 1.0
To: liwp.linux@gmail.com
Subject: Re: [PATCH 7/7] mm/memory.c : cleanup the coding style issue
References: <1339766449-7835-1-git-send-email-liwp.linux@gmail.com>
In-Reply-To: <1339766449-7835-1-git-send-email-liwp.linux@gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: cl@linux-foundation.org, srikar@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org, mhocko@suse.cz,
 paul.gortmaker@windriver.com, hpa@zytor.com, lwoodman@redhat.com,
 aarcange@redhat.com, sfr@canb.auug.org.au, shangw@linux.vnet.ibm.com,
 x86@kernel.org, hughd@google.com, mingo@redhat.com,
 kosaki.motohiro@jp.fujitsu.com, jan.kiszka@siemens.com, nacc@us.ibm.com,
 a.p.zijlstra@chello.nl, mel@csn.ul.ie, jason.wessel@windriver.com,
 viro@zeniv.linux.org.uk, bhelgaas@google.com, cgroups@vger.kernel.org,
 tglx@linutronix.de, kamezawa.hiroyu@jp.fujitsu.com, dhowells@redhat.com,
 trivial@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 miltonm@bga.com, minchan@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
 tj@kernel.org, rientjes@google.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/mm/memory.c b/mm/memory.c
> index 1b7dc66..195d6e1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2447,7 +2447,8 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	return same;
>  }
>  
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline void cow_user_page(struct page *dst, struct page *src,
> +		unsigned long va, struct vm_area_struct *vma)
>  {
>  	/*
>  	 * If the source page was a PFN mapping, we don't have

Nowadays, many developers prefer to declare a function in one line. and we don't think
this is incorrect anymore. so, I think this is intentional.
