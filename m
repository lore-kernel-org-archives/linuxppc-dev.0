Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 232BDDE55B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:40:35 +1100 (EST)
Message-ID: <47E938A8.9000103@semihalf.com>
Date: Tue, 25 Mar 2008 18:38:48 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>	
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
In-Reply-To: <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
[...]
> (copied from my comments in an off-list conversation)
> 
> However, I have declined (for now) to pick up the defconfigs for those
> boards and instead merged in the config features they require into the
> mpc5200 defconfig.  My primary reason for doing so is to increase the
> likelyhood that full featured kernels are built and tested so that
> situations where board ports conflict with each other are caught and
> fixed.
> 
> ojn has also been complaining about the number of defconfigs he needs
> to build to test all the powerpc configurations without any
> indications about which ones are important and which ones are not.
> There has been some discussion about having a subdirectory for
> optimized board configs, but nobody has done anything about it yet.
> 
> The one part that I have a really strong opinion on is that there
> should be a full featured mpc5200 defconfig for build testing.  Beyond
> that (and if ojn can also be appeased) I can probably be convinced.  :-)

Hi Grant,

How to deal with a situation where I need a particular PHY driver from
libphy compiled in the kernel for one of the MPC5200 boards? Adding it
to mpc5200_defconfig doesn't seem like a right thing to do. How to
convince you (and appease ojn) to accept a patch that adds a
board-specific defconfig that only slightly differs from
mpc5200_defconfig? :)

Regards,
Bartlomiej
