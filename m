Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id ACD64DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 22:28:41 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so385829nfd.9
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 05:28:37 -0700 (PDT)
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 4/5] LED driver
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141039.25e14fae@lappy.seanm.ca>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sun, 13 Apr 2008 14:28:24 +0200
In-Reply-To: <20080412141039.25e14fae@lappy.seanm.ca> (Sean MacLennan's
	message of "Sat\, 12 Apr 2008 14\:10\:39 -0400")
Message-ID: <87r6daym53.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Sean" == Sean MacLennan <smaclennan@pikatech.com> writes:

Hi,

 Sean> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
 Sean> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
 Sean> index 859814f..31e1746 100644
 Sean> --- a/drivers/leds/Kconfig
 Sean> +++ b/drivers/leds/Kconfig
 Sean> @@ -145,6 +145,12 @@ config LEDS_CLEVO_MAIL
 Sean>  	  To compile this driver as a module, choose M here: the
 Sean>  	  module will be called leds-clevo-mail.
 
 Sean> +config LEDS_WARP
 Sean> +	tristate "LED Support for the PIKA Warp LEDs"
 Sean> +	depends on LEDS_CLASS && WARP
 Sean> +	help
 Sean> +	  This option enables support for the PIKA Warp LEDs.
 Sean> +
 Sean>  comment "LED Triggers"

How about getting gpiolib working and use leds-gpio.c instead?

-- 
Bye, Peter Korsgaard
