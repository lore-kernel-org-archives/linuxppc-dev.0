Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8465767A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 09:55:59 +1100 (EST)
In-Reply-To: <1111524464.2987.69.camel@ad.doubleclick.net>
References: <1111524464.2987.69.camel@ad.doubleclick.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e1c2f47adf6d371e11cb28f7e15952f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 22 Mar 2005 16:56:00 -0600
To: "Jason McMullan" <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] MPC85xx CDS - Time Of Day, Cache settings, CPM IRQs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Some feedback on the patches:

* I'm not going to accept the printing of caches enabled, etc.  If you 
want to do this add sysfs attributes to the CPU.  That is more useful 
going forward and we dont have to do it for every board then.  (Plus we 
can add other attributes)

* TODC should already exist in 2.6.12-rc1

* I'll take a look at the CPM changes

- kumar

On Mar 22, 2005, at 2:47 PM, Jason McMullan wrote:

> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> Date: March 22, 2005 2:49:12 PM CST
> Subject:
>
>
>
> Date: March 22, 2005 2:49:12 PM CST
> Subject:
>
>
> <ATT118674.txt><board-ppc-mpc85xx-cds.patch>
>
> <signature.asc>
>
