Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id A21FFDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 22:49:29 +1100 (EST)
In-Reply-To: <474EA159.2040200@anagramm.de>
Subject: Re: DS1337 RTC on I2C broken.
To: Clemens Koller <clemens.koller@anagramm.de>
Message-ID: <OF72889778.967E4ED4-ONC12573A2.003EEB4F-C12573A2.003F93BA@abengoa.com>
Date: Thu, 29 Nov 2007 12:34:11 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I am trying to use some devices on i2c protocol, one of them is the DS1=
337
RTC, but I don't know too much about how.
I am using the Linux kernel 2.6.15 and a mpc866 processor. I've seen th=
ere
is a cpm i2c interface for these processors (for a rpx board). However =
the
corresponding code (i2c-algo8xx) doesn't appear in the sources. The
i2c-rpx.c just initializes the ioports, the adapter struct and the isr.=

Maybe I am not understanding the i2c driver right.
I am a bit confused about it. Could you give me some help about how it
works or what should I have to do?

Thanks in advance.
Best regards,

Ra=FAl Moreno



Clemens Koller <clemens.koller@anagramm.de>
Clemens Koller
Enviado por:
linuxppc-embedded-bounces+raul.moreno=3Dtelvent.abengoa.com@ozlabs.org
29/11/2007 12:24
                                                                       =
                                                
 Para:   Alessandro Zummo <alessandro.zummo@towertech.it>              =
                                                
                                                                       =
                                                
 cc:     rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org      =
                                                
                                                                       =
                                                
 Asunto: Re: DS1337 RTC on I2C broken.                                 =
                                                
                                                                       =
                                                





Hello, Allessandro!

Alessandro Zummo schrieb:
 > On Wed, 28 Nov 2007 19:25:00 +0100
 > Clemens Koller <clemens.koller@anagramm.de> wrote:
 >
 >> Well, as already mentioned, I have problems to get my DS1337 RTC on=
 I2C
 >> on my MPC8540(ads like) PowerPC working properly on
 >> latest 2.6.24-rc2-ge6a5c27f kernels. A paulus.git 2.6.21-rc5-g9a5ee=
4cc
 >> as well as a 2.6.22-rc6-gb75ae860 is working fine.
 >> (mainstream's console is broken, so cannot test these, yet.)

Just to give you an update: The latest paulus.git as of today
(Linux-2.6.24-rc3-g0b47759d) is still broken. Same story as yesterday.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Stra=DFe 45/1
Linhof Werksgel=E4nde
D-81379 M=FCnchen
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
=
