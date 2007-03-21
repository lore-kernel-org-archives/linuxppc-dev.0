Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15E7CDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 22:20:07 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Wed, 21 Mar 2007 14:23:40 +0300
References: <200703161634.58444.yur@emcraft.com>
	<200703171441.51276.yur@emcraft.com>
	<17921.3150.242081.66071@cargo.ozlabs.ibm.com>
In-Reply-To: <17921.3150.242081.66071@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703211423.40508.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Paul,

On Wednesday 21 March 2007 13:43, you wrote:
> Yuri Tikhonov writes:
> >  Do you think that replacing one integer option CONFIG_PPC_PAGE_SHIFT
> > with three logical options (i.e., CONFIG_PPC_PAGE_SIZE_4K,
> > CONFIG_PPC_PAGE_SIZE_16K and CONFIG_PPC_PAGE_SIZE_64K) will be the better
> > choice ?
>
> I think you should use a choice...endchoice construct in Kconfig,
> which will result in 2 config options, or 3 if you choose to support
> 16k pages.

 Yes, there will be 3 options. Thank you!

 Regards, Yuri.

>
> Paul.
