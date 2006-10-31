Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D01167BB3
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 05:32:31 +1100 (EST)
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [DTC][PATCH] increment default output blob version from 3 to 16 
In-Reply-To: Your message of "Mon, 30 Oct 2006 10:48:59 CST."
	<20061030104859.017cb613.kim.phillips@freescale.com>
References: <20061030104859.017cb613.kim.phillips@freescale.com> 
Date: Tue, 31 Oct 2006 12:32:24 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GeyPQ-0004lv-1d@jdl.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kim Phillips mumbled:
> increment default output blob version from 3 to 16
> 

> diff --git a/dtc.c b/dtc.c
> index 646b814..3cb94e6 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
>  	int opt;
>  	FILE *inf = NULL;
>  	FILE *outf = NULL;
> -	int outversion = 3;
> +	int outversion = 0x10;
>  	int reservenum = 1;
>  	int boot_cpuid_phys = 0xfeedbeef;


So, I am inclined to accept this change since we all pretty
much really need version 16 for what we are doing.

Will changing this default really annoy anyone out there?

Thanks,
jdl
