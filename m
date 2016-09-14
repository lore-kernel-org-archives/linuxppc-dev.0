Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYhmR1sJZzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 10:11:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/sparse: Make a bunch of things static
In-Reply-To: <1473139963-7496-2-git-send-email-dja@axtens.net>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <1473139963-7496-2-git-send-email-dja@axtens.net>
Date: Wed, 14 Sep 2016 10:11:34 +1000
Message-ID: <877fafpcg9.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 05f09ae82587..95abca69b168 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1608,7 +1608,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
>  	return ret;
>  }
>  
> -ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
> +static ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
>  			   size_t len, loff_t *ppos)
>  {
>  	return -EACCES;

I dropped these hunks, because they touch arch/powerpc/kvm and so should
technically go via Paul.

Can you resend them to him?

cheers
