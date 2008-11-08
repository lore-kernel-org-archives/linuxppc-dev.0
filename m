Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84ED5DDE04
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 05:21:04 +1100 (EST)
Message-Id: <CADE371E-97EB-46D1-8F09-FD53AEE4961C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811052153.57292.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH V3] powerpc: Fix Book-E watchdog timer interval setting
Date: Sat, 8 Nov 2008 12:20:32 -0600
References: <200811052153.57292.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 2:53 PM, Matthias Fuchs wrote:

> This patch fixes the setting of the Book-E watchdog timer interval  
> setup
> on initialization and by ioctl().
>
> On initialization the period bits have to be masked before setting
> a new period.
>
> In WDIOC_SETTIMEOUT ioctl we have to use the correct mask.
>
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> ---
> drivers/watchdog/booke_wdt.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)

applied to merge

- k
