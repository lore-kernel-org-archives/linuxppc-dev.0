Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F1E89DDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 22:50:14 +1000 (EST)
Message-ID: <47175683.1030407@grandegger.com>
Date: Thu, 18 Oct 2007 14:50:11 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
In-Reply-To: <4708C22D.5060805@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I see one more issue.

Marian Balakowicz wrote:
> Add device tree source file for Motion-PRO board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
[deletions]
> +		gpio@b00 {
> +			compatible = "mpc5200b-gpio\0mpc5200-gpio";
> +			reg = <b00 40>;
> +			interrupts = <1 7 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

Do we not need the field "device_type = "gpio" here?

> +		gpio-wkup@c00 {
> +			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
> +			reg = <c00 40>;
> +			interrupts = <1 8 0 0 3 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

And the same here.

Wolfgang.
