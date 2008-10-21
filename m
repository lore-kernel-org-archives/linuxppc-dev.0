Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A9C7DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:39:37 +1100 (EST)
Message-Id: <E9D64800-2508-434A-AE6C-13CAB6EB1325@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] powerpc/83xx: add support for MCU on 8349emitx,
	837xrdb and 8315erdb boards
Date: Mon, 20 Oct 2008 23:39:29 -0500
References: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 17, 2008, at 1:57 PM, Anton Vorontsov wrote:

> MCU is an external Freescale MC9S08QG8 microcontroller, mainly used to
> provide soft power-off function, but also exports two GPIOs (wired to
> the LEDs and also available from the external headers).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8315erdb.dts  |    8 ++++++++
> arch/powerpc/boot/dts/mpc8349emitx.dts |    8 ++++++++
> arch/powerpc/boot/dts/mpc8377_rdb.dts  |    8 ++++++++
> arch/powerpc/boot/dts/mpc8378_rdb.dts  |    8 ++++++++
> arch/powerpc/boot/dts/mpc8379_rdb.dts  |    8 ++++++++
> 5 files changed, 40 insertions(+), 0 deletions(-)

applied

- k
