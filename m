Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65D88B7DD2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:44:06 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA1BCDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:44:05 +1000 (EST)
Message-Id: <0119F5B1-A89A-4089-874B-CD4C0EE881A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090724214217.GA2718@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/2] powerpc/83xx: Add support for MPC8377E-WLAN boards
Date: Thu, 6 Aug 2009 21:44:01 -0500
References: <20090724214217.GA2718@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 24, 2009, at 4:42 PM, Anton Vorontsov wrote:

> MPC8377E-WLAN are basically RDB boards except:
>
> - RAM extended to 512 MB;
> - NAND flash removed, NOR flash extended to 64 MB;
> - Vitesse VSC7385 5-port switch removed, RTL8211B PHY added;
> - Power management MCU removed;
> - PCI slot removed, another mini-PCI slot added (IRQ routing changed);
> - USB3300 PHY's ID pin grounded, thus USB port is host-only.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_wlan.dts    |  464 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig       |    4 +-
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    5 +-
> 3 files changed, 469 insertions(+), 4 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8377_wlan.dts


applied to next.

- k
