Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 995DDDDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 01:44:52 +1100 (EST)
Message-Id: <6A6D7DCB-067A-4891-B922-536765D6E6FB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081107143818.9129.47899.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Watchdog timer support for GE Fanuc SBC610
Date: Fri, 7 Nov 2008 08:44:45 -0600
References: <20081107143818.9129.47899.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 7, 2008, at 8:38 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Baord Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This patch adds support for the watchdog timer in the devices main  
> FPGA.
> There are two identical watchdog timers at different offsets in the  
> main
> FPGA, this driver is capable of supporting one of them. The watchdog  
> timers
> are also capable of generating interrupts at a user-configurable  
> threshold,
> though support for this operation is currently not supported by the  
> driver.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts           |   19 +
> arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1
> drivers/watchdog/Kconfig                       |    6
> drivers/watchdog/Makefile                      |    1
> drivers/watchdog/gef_wdt.c                     |  333 +++++++++++++++ 
> +++++++++
> 5 files changed, 360 insertions(+), 0 deletions(-)

Can you break this into two patches.  One for the driver and one for  
the arch/powerpc stuff.  the driver should go via the watchdog  
maintainer (and CC that list).

- k
