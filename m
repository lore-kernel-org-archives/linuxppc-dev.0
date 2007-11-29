Return-Path: <clemens.koller@anagramm.de>
Message-ID: <474EB3DD.7030407@anagramm.de>
Date: Thu, 29 Nov 2007 13:43:09 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: raul.moreno@telvent.abengoa.com
Subject: Re: DS1337 RTC on I2C broken.
References: <OF72889778.967E4ED4-ONC12573A2.003EEB4F-C12573A2.003F93BA@abengoa.com>
In-Reply-To: <OF72889778.967E4ED4-ONC12573A2.003EEB4F-C12573A2.003F93BA@abengoa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello, Raul!

raul.moreno@telvent.abengoa.com schrieb:
 > I am trying to use some devices on i2c protocol, one of them is the DS1337
 > RTC, but I don't know too much about how.
 > I am using the Linux kernel 2.6.15 and a mpc866 processor.

I don't remember too much about these old kernels.
And, please notice, that
- I am on an mpc8540 which is quite different from your mpc866 processor.
- I am on the latest kernels which are also very different from the old
ones regarding the RTC subsystem.

Usually you have to configure the kernel using the right i2c interface
for your processor (if supported). I am using the 'fsl-i2c' driver
enabled by: I2C-support -> I2C Hardware Bus support -> MPC107/824x/85xx/52xx/86xx
which will be:
CONFIG_I2C_MPC=y

Then, you might have to enable the (now deprecated)
Misc I2C Chip Support -> Dallas DS1337 and ... Real Time Clock support
which gives you:
CONFIG_SENSORS_DS1337=y

 > I've seen there
 > is a cpm i2c interface for these processors (for a rpx board).

the fsl-i2c might be the right place

 > However the
 > corresponding code (i2c-algo8xx) doesn't appear in the sources. The
 > i2c-rpx.c just initializes the ioports, the adapter struct and the isr.
 > Maybe I am not understanding the i2c driver right.
 > I am a bit confused about it. Could you give me some help about how it
 > works or what should I have to do?

I would suggest - despite the current problems - to use a current
kernel and check your mileage there.
I don't want to ride dead horses anymore.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
