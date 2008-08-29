Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10581DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:04:35 +1000 (EST)
Message-Id: <7E18A542-EA62-4F5B-992C-8AC3D9562F72@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080826131344.12883.60435.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v3 1/2] powerpc: Board support for GE Fanuc SBC610
Date: Fri, 29 Aug 2008 07:04:18 -0500
References: <20080826131339.12883.61796.stgit@ubuntu8041.localdomain>
	<20080826131344.12883.60435.stgit@ubuntu8041.localdomain>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 26, 2008, at 8:13 AM, Martyn Welch wrote:

> +
> +		PowerPC,8641@0 {
> +			device_type = "cpu";
> +			reg = <0x00000000>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <32768>;		// L1, 32K
> +			i-cache-size = <32768>;		// L1, 32K

>
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;		// From uboot
> +			clock-frequency = <0>;		// From uboot

you can remove these since u-boot will set them.

>
> +		};
> +		PowerPC,8641@1 {
> +			device_type = "cpu";
> +			reg = <0x00000001>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <32768>;		// L1, 32K
> +			i-cache-size = <32768>;		// L1, 32K

>
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;		// From uboot
> +			clock-frequency = <0>;		// From uboot

you can remove these since u-boot will set them.

>
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>;	// set by u-boot

if the comment is zero just set it to <0 0>;

>
> +	};
> +

what u-boot version are you using/shipping with these boards?   
Wondering if other props (like cache info, is set by u-boot for you).

- k
