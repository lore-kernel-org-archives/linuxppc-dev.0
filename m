Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44A472C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 14:06:21 +1100 (EST)
Message-ID: <1395543886.3460.95.camel@pasglop>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laura Abbott <lauraa@codeaurora.org>
Date: Sun, 23 Mar 2014 14:04:46 +1100
In-Reply-To: <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
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


> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1594945..8122294 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -82,6 +82,7 @@ config ARM
>  	  <http://www.arm.linux.org.uk/>.
>  
>  config ARM_HAS_SG_CHAIN
> +	select ARCH_HAS_SG_CHAIN
>  	bool
>  

Heh, a self-selecting config option... I didn't know that trick !

Ben.
