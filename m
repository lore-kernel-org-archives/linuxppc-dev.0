Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4633DDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:32:01 +1000 (EST)
Message-Id: <797E5A34-6C17-4E5C-A881-4B04528FBDA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080611230437.GD21351@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] powerpc/86xx: mpc8610_hpcd: add support for ULI RTC
Date: Tue, 15 Jul 2008 08:31:55 -0500
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
	<20080611230437.GD21351@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 6:04 PM, Anton Vorontsov wrote:

> The ULI "Super South Bridge" contains ISA bridge to the legacy
> devices, such as Super IO mouse/keyboard/floppy disk controllers,
> parallel port, i8259 interrupt controller and so on.
>
> i8259 is disabled on the MPC8610HPCD, and other peripherals are not
> traced out. So we use only RTC.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   14 +++++++
> arch/powerpc/configs/mpc8610_hpcd_defconfig |   51 ++++++++++++++++++ 
> ++++++--
> 2 files changed, 61 insertions(+), 4 deletions(-)

applied.

- k
