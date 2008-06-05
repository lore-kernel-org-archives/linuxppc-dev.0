Return-Path: <galak@kernel.crashing.org>
Message-Id: <4188A8A4-BDF9-4D23-A874-19C6A9A18E71@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <48481E86.1060302@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v3 2/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Date: Thu, 5 Jun 2008 13:58:16 -0500
References: <48481E86.1060302@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> ===================================================================
> --- /dev/null
> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
>

> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};

is memory fixed on this board to 256M?

just let me know and I can fix when I commit it.

- k
