Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id E5BF4B7D1E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 22:33:23 +1000 (EST)
Received: by wyb32 with SMTP id 32so1136758wyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 05:33:22 -0700 (PDT)
Message-ID: <4BFFB7DD.2080806@ru.mvista.com>
Date: Fri, 28 May 2010 16:32:29 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH]Device tree update for the 460ex DWC SATA
References: <201005281215.o4SCFKNi025548@amcc.com>
In-Reply-To: <201005281215.o4SCFKNi025548@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, rsarmah@appliedmicro.com, sr@denx.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Rupjyoti Sarmah wrote:

> Device tree update for the Applied micro processor 460ex on-chip SATA.

> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>

[...]

> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index cd56bb5..d3b2c99 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -163,6 +163,14 @@
>  			interrupts = <0x1e 4>;
>  		};
>  
> +		SATA0: sata@bffd1000 {
> +                        compatible = "amcc,sata-460ex";
> +			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
> +                        interrupt-parent = <&UIC3>;
> +                        interrupts = <0x0 0x4       /* SATA */
> +                                      0x5 0x4>;     /* AHBDMA */

    Please indent only using tabs consistently.

WBR, Sergei
