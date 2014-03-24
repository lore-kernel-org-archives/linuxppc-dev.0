Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1852E2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 16:47:19 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Mon, 24 Mar 2014 05:47:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3145A17D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 05:47:55 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2O5kwQB56819736
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 05:46:58 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2O5l7qE028143
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 23:47:09 -0600
Date: Mon, 24 Mar 2014 06:47:06 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
Message-ID: <20140324054706.GA4487@osiris>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linux390@de.ibm.com,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 22, 2014 at 11:13:51AM -0700, Laura Abbott wrote:
> Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> specific scatterlist.h, make it a proper Kconfig option and use that
> instead. At same time, remove the header files are are now mostly
> useless and just include asm-generic/scatterlist.h.
> 

[...]

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 65a0775..d6c2059 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -142,6 +142,7 @@ config S390
>  	select SYSCTL_EXCEPTION_TRACE
>  	select VIRT_CPU_ACCOUNTING
>  	select VIRT_TO_BUS
> +	select ARCH_HAS_SG_CHAIN
> 

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

FWIW, it would have been nice to keep the list of selected configs sorted.
However no need to resend.
