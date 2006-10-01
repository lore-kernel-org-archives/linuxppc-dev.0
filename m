Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEE5867BEA
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 14:36:41 +1000 (EST)
In-Reply-To: <17694.23677.886959.674776@cargo.ozlabs.ibm.com>
References: <451E4808.7010004@freescale.com>
	<17694.23677.886959.674776@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A853E740-BAF5-465E-AE5C-8FA38B14C897@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Change ucc_geth driver to use of_device
Date: Sat, 30 Sep 2006 23:37:13 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 30, 2006, at 7:01 AM, Paul Mackerras wrote:

> Li Yang writes:
>
>> This patch change ucc_geth driver to use of_device from
>> platform_device.  It also fix a bug that bcsr_regs gets
>> accidentally unmapped.  Remove trailing space.
>
> So, does this go on top of your series of 9 patches, or is it instead
> of one of them?

I'm not quite sure myself at this point, but would like to see the  
patches merged into one set, instead of patches on top of patches.  I  
still have a number of comments before I think the QE lib code is in  
a form that we should accept.

However, the "[PATCH] Fix rheap alignment problem" can go into tree  
at any time.

http://patchwork.ozlabs.org/linuxppc/patch?id=7202

- kumar
