Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 51B002C03CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 07:41:16 +1100 (EST)
Subject: Re: [PATCH 1/1] book3e/corenet64: increase CPU numbers by default
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1361871198-942-1-git-send-email-tiejun.chen@windriver.com>
Date: Fri, 8 Mar 2013 14:39:04 -0600
Message-Id: <8CEF681C-D628-4BF3-A4CC-B412230997E5@kernel.crashing.org>
References: <1361871198-942-1-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2013, at 3:33 AM, Tiejun Chen wrote:

> Currently we already support p5040ds which has 4 e5500 cores, but
> twelve dual-threaded e6500 cores are also built on T4240, we can
> change CONFIG_NR_CPUS with this value now.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
> arch/powerpc/configs/corenet64_smp_defconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

I've handled this as part of the T4 baseline support patchset.

- k
