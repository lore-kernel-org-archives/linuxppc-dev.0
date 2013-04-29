Return-Path: <htejun@gmail.com>
Received: from mail-da0-x234.google.com (mail-da0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F1D82C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 08:55:20 +1000 (EST)
Received: by mail-da0-f52.google.com with SMTP id j17so3150300dan.39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 15:55:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Apr 2013 15:55:13 -0700
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <20130429225513.GG2395@htj.dyndns.org>
References: <20130429140433.92d05cd48b66ac323616d572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130429140433.92d05cd48b66ac323616d572@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
 linux-next@vger.kernel.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Mon, Apr 29, 2013 at 02:04:33PM +1000, Stephen Rothwell wrote:
> I have added the following merge fix patch for today (but it should be
> applied to the powerpc tree ASAP).
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 29 Apr 2013 14:01:44 +1000
> Subject: [PATCH] powerpc: numa.c: using kzalloc/kfree requires including
>  slab.h
> 
> fixes these build errors:
> 
> arch/powerpc/mm/numa.c: In function 'arch_update_cpu_topology':
> arch/powerpc/mm/numa.c:1465:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
> arch/powerpc/mm/numa.c:1465:10: error: assignment makes pointer from integer without a cast [-Werror]
> arch/powerpc/mm/numa.c:1497:2: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Tejun Heo <tj@kernel.org>

Benjamin, can you please pick this up?

Thanks a lot and sorry about the trouble.

-- 
tejun
