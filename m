Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4E3DDE56D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 00:32:46 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3AEWgxq017083
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:32:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3AEWWUw062278
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:32:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3AEWHIg013473
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:32:18 -0600
Date: Thu, 10 Apr 2008 09:30:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 1 of 3] [POWERPC 44x] Export tlb_44x_hwater for KVM
Message-ID: <20080410093012.6b524347@zod.rchland.ibm.com>
In-Reply-To: <d1804f03574745f4f8f5.1207601612@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
	<d1804f03574745f4f8f5.1207601612@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Apr 2008 15:53:32 -0500
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> 1 file changed, 2 insertions(+)
> include/asm-powerpc/mmu-44x.h |    2 ++
> 
> 
> PowerPC 440 KVM needs to know how many TLB entries are used for the host kernel
> linear mapping (it does not modify these mappings when switching between guest
> and host execution).
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

> 
> diff --git a/include/asm-powerpc/mmu-44x.h b/include/asm-powerpc/mmu-44x.h
> --- a/include/asm-powerpc/mmu-44x.h
> +++ b/include/asm-powerpc/mmu-44x.h
> @@ -53,6 +53,8 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +extern unsigned int tlb_44x_hwater;
> +
>  typedef unsigned long long phys_addr_t;
> 
>  typedef struct {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
