Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 551ACDE4BE
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 02:06:29 +1000 (EST)
Message-Id: <9079D868-FA0E-4CC9-97DE-BF0EB1085559@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
In-Reply-To: <20080508134700.4313e967@neuromancer.mindspace>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH][v2] Add support for Analogue & Micro ASP837E board
Date: Fri, 30 May 2008 11:06:13 -0500
References: <20080508134700.4313e967@neuromancer.mindspace>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 8, 2008, at 7:47 AM, Bryan O'Donoghue wrote:

> Greetings.
>
> Attached is a patchset to support the  ASP8347E.
>
> http://www.analogue-micro.com/ASP8347.html. Due to the fact that the  
> board
> shipped with a root filesystem that requires devfs, you have to run  
> a different
> rootfs with all current kernels. I've been using the 8xx root fs  
> from the ELDK
> via NFS, for this.
>
> v2 implements all changes - bar ethernet aliases in the dts, as  
> suggested
> by Stephen Rothwell and Kumar Gala, to date.
>
> Please apply.
>
> Cheers,
> Bryan
>
> Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
> ---

applied to powerpc-next.

I had to make a few changes to this patch.  In the future please make  
sure the commit message
is before the ---.  Also, look at running scripts/checkpatch.pl.

- k
