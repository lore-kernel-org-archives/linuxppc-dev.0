Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 664DC679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 20:34:24 +1000 (EST)
Message-ID: <429D9115.9040806@ru.mvista.com>
Date: Wed, 01 Jun 2005 14:42:29 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: colui77@virgilio.it
References: <4293EE1500015698@ims2a.cp.tin.it>
In-Reply-To: <4293EE1500015698@ims2a.cp.tin.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ML300-gpio
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

colui77@virgilio.it wrote:
> hi all,
> I'm working with the ML300 platform running the shipped Montavista Linux
> (and hw configuration). I need to use the onboard gpio and I found a driver,
> the xilinx_gpio, that I have loaded (insmod xilinx_gpio). After insmoding
> the driver it is registered in /dev/xgpio (why is not it loaded in /proc/
> before?) I have tried to use the GPIOs...
> 
> cat "111111000000" > /dev/xgpio

You must use ioctl's.
This driver has the same API as IBM OCP GPIO driver.
Please check include/linux/ibm_ocp_gpio.h.

Thanks,
Andrei

> I was expecting some leds lighting but nothing at all...
> Is there someone experienced with the ml300 gpios? 
> Please I need help
> Luigi
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
