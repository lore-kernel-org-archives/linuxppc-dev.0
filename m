Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 240F6DDF7B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 01:45:23 +1100 (EST)
Message-Id: <01A072FA-4E81-4C96-96F8-0BF2BE2977C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081107134343.7844.77855.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/86xx: Correct SOC bus-frequency in GE Fanuc
	SBC610 DTS
Date: Fri, 7 Nov 2008 08:45:11 -0600
References: <20081107134343.7844.77855.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 7, 2008, at 7:43 AM, Martyn Welch wrote:

> This patch corrects the bus-frequency value provided in the SBC610's  
> dts.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/ 
> boot/dts/gef_sbc610.dts
> index fd2b606..1f7833c 100644
> --- a/arch/powerpc/boot/dts/gef_sbc610.dts
> +++ b/arch/powerpc/boot/dts/gef_sbc610.dts
> @@ -114,7 +114,7 @@
> 		compatible = "simple-bus";
> 		ranges = <0x0 0xfef00000 0x00100000>;
> 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
> -		bus-frequency = <0>;
> +		bus-frequency = <33333333>;
>
> 		i2c1: i2c@3000 {
> 			#address-cells = <1>;

are we not fixing this up in u-boot?

- k
