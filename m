Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tKKCP0qllzDvrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 22:48:48 +1100 (AEDT)
Subject: Re: [PATCH 1/2] soc: fsl: make it explicitly non-modular
To: linuxppc-dev@lists.ozlabs.org
References: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Yangbo Lu <yangbo.lu@nxp.com>,
 Arnd Bergmann <arnd@arndb.de>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <ac420439-8ee5-397f-aa2b-c530680685d9@arm.com>
Date: Thu, 17 Nov 2016 11:48:38 +0000
MIME-Version: 1.0
In-Reply-To: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 16:39, Sudeep Holla wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/soc/fsl/Kconfig:config FSL_GUTS
> drivers/soc/fsl/Kconfig:   bool
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

I saw Paul Gortmaker had sent similar patch on Nov 15, so drop/ignore this.

-- 
Regards,
Sudeep
