Return-Path: <evilninja@gmx.net>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34E9367BAD
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Sep 2006 16:45:27 +1000 (EST)
Date: Sun, 10 Sep 2006 07:15:47 +0100 (BST)
From: Christian <evilninja@gmx.net>
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: 'make ARCH=ppc defconfig' failing for cross-compile
In-Reply-To: <20060909000512.GF9335@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0609100652160.16347@sheep.housecafe.de>
References: <20060909000512.GF9335@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 8 Sep 2006, Judith Lebzelter wrote:
> I have been doing cross-compiles for ppc and powerpc on my i686 system.
> In order to do this I generate the .config file like this:
>
> make ARCH=ppc defconfig
> (or make ARCH=powerpc defconfig)

Seems like defconfig has been removed, because there are so many 
sub-platforms for ppc:

$ ls arch/ppc/configs/*defconfig | wc -l
56

Just pick the defonfig for your platform, for my PReP that'd be:

$ make ARCH=ppc CROSS_COMPILE=powerpc-604-linux-gnu- prep_defconfig


HTH,
Christian.
-- 
BOFH excuse #383:

Your processor has taken a ride to Heaven's Gate on the UFO behind Hale-Bopp's comet.
