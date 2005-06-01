Return-Path: <colui77@virgilio.it>
Received: from vsmtp14.tin.it (vsmtp14.tin.it [212.216.176.118])
	by ozlabs.org (Postfix) with ESMTP id 610D6679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 20:21:18 +1000 (EST)
Received: from ims2a.cp.tin.it (192.168.70.102) by vsmtp14.tin.it (7.0.027)
	id 429D6F260000D80F for linuxppc-embedded@ozlabs.org;
	Wed, 1 Jun 2005 12:21:15 +0200
Date: Wed, 1 Jun 2005 12:21:14 +0200
Message-ID: <4293EE1500015698@ims2a.cp.tin.it>
From: colui77@virgilio.it
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Subject: ML300-gpio
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,
I'm working with the ML300 platform running the shipped Montavista Linux
(and hw configuration). I need to use the onboard gpio and I found a driv=
er,
the xilinx_gpio, that I have loaded (insmod xilinx_gpio). After insmoding=

the driver it is registered in /dev/xgpio (why is not it loaded in /proc/=

before?) I have tried to use the GPIOs...

cat "111111000000" > /dev/xgpio

I was expecting some leds lighting but nothing at all...
Is there someone experienced with the ml300 gpios? 
Please I need help
Luigi
