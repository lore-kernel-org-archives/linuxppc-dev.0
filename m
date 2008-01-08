Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5EA8DDF6A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 07:13:04 +1100 (EST)
Message-ID: <4783B74D.1040501@freescale.com>
Date: Tue, 08 Jan 2008 10:47:57 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 7/7] Add MPC512x PSC serial driver
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-8-git-send-email-jrigby@freescale.com>
	<fa686aa40801080932g71fb6215wc3d6df107bec7238@mail.gmail.com>
In-Reply-To: <fa686aa40801080932g71fb6215wc3d6df107bec7238@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the quick feedback Grant.

Grant Likely wrote:
> Exactly *how* different is the 5121 PSC from the 5200 PSC?  If it is
> really different, then it makes sense to clone. 
The fifo handling has completely changed that is the main difference.
>  In fact; I'd
> duplicate the mpc52xx_psc.h file also to avoid any crossover.
>   
I agree.

> However, if the differences are manegable, I'd rather see a single
> driver that can drive either type of PSC.  In fact, can you post a
> diff between this driver and the original PSC driver?
>   
I simple diff will mostly show the removal of arch/ppc support so
won't be much help.  How about I do take a pass at a new version
that supports 52xx and 512x but only for arch/powerpc?
