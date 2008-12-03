Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8485DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:58:08 +1100 (EST)
Message-Id: <5A5F3139-F5AC-41B3-9B09-0416B9BB4BE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081107141414.8523.68990.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v4] powerpc: Basic GPIO support for GE Fanuc SBC610
Date: Wed, 3 Dec 2008 09:58:00 -0600
References: <20081107141414.8523.68990.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 7, 2008, at 8:15 AM, Martyn Welch wrote:

> Basic support for the GPIO available on the SBC610 VPX Single Board  
> Computer
> from GE Fanuc (PowerPC MPC8641D).
>
> This patch adds basic support for the GPIO in the devices I/O FPGA,  
> the GPIO
> functionality is exposed through the AFIX pins on the backplane,  
> unless used
> by an AFIX card.
>
> This code currently does not support switching between totem-pole and
> open-drain outputs (when used as outputs, GPIOs default to totem- 
> pole).
> The interrupt capabilites of the GPIO lines is also not currently  
> supported.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> Anton: Thank you for your fast response.
>
> Changes since version 3:
> * Removed repetitive and obvious comments
> * Removed stray empty line
>
> arch/powerpc/boot/dts/gef_sbc610.dts   |    6 +
> arch/powerpc/platforms/86xx/Kconfig    |    2
> arch/powerpc/platforms/86xx/Makefile   |    3 -
> arch/powerpc/platforms/86xx/gef_gpio.c |  143 +++++++++++++++++++++++ 
> +++++++++
> 4 files changed, 153 insertions(+), 1 deletions(-)

applied to next

- k
