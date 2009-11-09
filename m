Return-Path: <hollisb@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED29EB7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 10:54:07 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA9IblAe011525
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 11:37:47 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nA9IcoNB238010
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 11:38:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA9IcncL014247
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 11:38:49 -0700
Subject: Re: [PATCH] powerpc/kvm: Fix non-modular build
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1257401928.13611.105.camel@pasglop>
References: <1257401928.13611.105.camel@pasglop>
Content-Type: text/plain
Date: Mon, 09 Nov 2009 10:38:46 -0800
Message-Id: <1257791926.21390.49.camel@conventional>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	kvmppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-05 at 17:18 +1100, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kvm/timing.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
> index 2aa371e..7037855 100644
> --- a/arch/powerpc/kvm/timing.c
> +++ b/arch/powerpc/kvm/timing.c
> @@ -23,6 +23,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
> +#include <linux/module.h>
> 
>  #include <asm/time.h>
>  #include <asm-generic/div64.h>

FYI, Olof submitted this patch already, but Avi didn't take it or
comment. Feel free to batch it in the agraf bundle (it is required to
make that build, after all).

Acked-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center
