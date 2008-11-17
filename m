Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E58EFDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 09:16:22 +1100 (EST)
Message-Id: <49889E01-9433-41BE-A6F1-66127856D482@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Silence timebase sync code
Date: Mon, 17 Nov 2008 16:14:10 -0600
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 17, 2008, at 3:58 PM, Trent Piepho wrote:

> It's over a dozen lines of output and doesn't appear to provide any  
> useful
> information.  Even after looking at the code, I'm in the dark about  
> what
> "score 299, offset 250" means.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/kernel/smp-tbsync.c |   12 ++++--------
> 1 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/ 
> smp-tbsync.c
> index bc892e6..b590135 100644
> --- a/arch/powerpc/kernel/smp-tbsync.c
> +++ b/arch/powerpc/kernel/smp-tbsync.c
> @@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
> {
> 	int i, score, score2, old, min=0, max=5000, offset=1000;
>
> -	printk("Synchronizing timebase\n");
> +	pr_info("Synchronizing timebase\n");

I think its useful to leave this as a printk.

- k
