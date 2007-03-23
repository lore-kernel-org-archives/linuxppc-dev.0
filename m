Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E212DDE029
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 01:09:44 +1100 (EST)
In-Reply-To: <20070322092202.20D73DDF32@ozlabs.org>
References: <20070322092202.20D73DDF32@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DB443D82-5C88-45F9-BF32-F12AA11244AA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/10] Port 44x MMU definitions to ARCH=powerpc
Date: Fri, 23 Mar 2007 09:09:11 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2007, at 4:22 AM, David Gibson wrote:

> This patch moves the mmu.h definitions which are still relevant for
> ARCH=powerpc from include/asm-ppc/mmu.h to their own file,
> include/asm-powerpc/mmu_44x.h.  The new file is included from
> asm-powerpc/mmu.h, and a couple of other tweaks to correct mmu
> definitions for 44x are made.
>
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
>
>  arch/powerpc/kernel/head_44x.S    |    4 -
>  arch/powerpc/mm/44x_mmu.c         |   81 ++++++ 
> +-------------------------------
>  arch/powerpc/mm/mmu_decl.h        |    2
>  include/asm-powerpc/mmu-44x/mmu.h |   75 ++++++++++++++++++++++++++ 
> +++++++++
>  include/asm-powerpc/mmu.h         |   11 ++++-
>  5 files changed, 105 insertions(+), 68 deletions(-)

Any reason you are creating a new directory in include/asm-powerpc  
for 44x mmu defn?  why not just mmu_44x.h or something like that?

- k
