Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B80D7DDF2E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 03:13:50 +1100 (EST)
Message-Id: <CA8FFE19-B84A-426B-9B1C-EF0F7C87AE47@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <4797641F.4000902@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCHv2 0/8] [POWERPC] 8xx cleanups
Date: Wed, 23 Jan 2008 10:11:01 -0600
References: <4797641F.4000902@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 9:58 AM, Jochen Friedrich wrote:

> Hi,
>
> this is a series against paulus for-2.6.25 tree to clean up various  
> 8xx related stuff.
> The series can be pulled from git://git.bocc.de/dbox2.git cleanup.
> Patch 6 has been modified to remove the #ifdefs as suggested by  
> Arndt Bergmann.
> Patch 8 is a new one.
>
> [POWERPC] Remove unused m8xx_cpm_hostalloc/free/dump()
> [POWERPC] Rename m8xx_pic_init to mpc8xx_pics_init
> [POWERPC] Remove unneeded and misspelled prototype m8xx_calibrate_decr
> [POWERPC] Remove declaration of m8xx_pic_init.
> [POWERPC] Remove sysdev/commproc.h
> [POWERPC] Get rid of conditional includes of board specific setup
> [POWERPC] Rename commproc to cpm1 and cpm2_common.c to cpm2.c
> [POWERPC] Move definition of buffer descriptor to cpm.h

These roughly look good, had a few comments.  Don't see any reason why  
they can't go in.

What impact do the have on boards in arch/ppc being able to build?

- k
