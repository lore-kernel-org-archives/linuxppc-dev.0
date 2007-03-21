Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17921.3150.242081.66071@cargo.ozlabs.ibm.com>
Date: Wed, 21 Mar 2007 21:43:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
In-Reply-To: <200703171441.51276.yur@emcraft.com>
References: <200703161634.58444.yur@emcraft.com>
	<17915.7048.393811.714143@cargo.ozlabs.ibm.com>
	<200703171441.51276.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov writes:

>  Do you think that replacing one integer option CONFIG_PPC_PAGE_SHIFT with 
> three logical options (i.e., CONFIG_PPC_PAGE_SIZE_4K, 
> CONFIG_PPC_PAGE_SIZE_16K and CONFIG_PPC_PAGE_SIZE_64K) will be the better 
> choice ?

I think you should use a choice...endchoice construct in Kconfig,
which will result in 2 config options, or 3 if you choose to support
16k pages.

Paul.
