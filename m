Message-ID: <40C02B94.8020709@iti.fi>
Date: Fri, 04 Jun 2004 10:58:12 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: iida <iida@ztec.com.br>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver SPI for MPC5200
References: <20040601173804.04313C109F@atlas.denx.de>
In-Reply-To: <20040601173804.04313C109F@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>>Or what i have to modify to use in mpc5200
>>
>>
>
>You need to write a new driver.
>
>

I have been doin such thing a while. The base idea is to hae similar
subsystem tha i2c has.
Least in my application i like to controll multiple diferent devices via
spi  and i like
that the spi connected targets look a like "normal" devides to linux
programs.
At the moment i am working spi core and drivers for tsc2301 ( system
management
chip / adc/audio ), MMC ( multimedi card ) and frame buffer device for
small 128x64
graphical LCD ( UC1606 Chip )

The thing that i am waiting is to get something clear to this DMA
problem that
has been discussed here lately.

The MPC5200 SPI device does not support Bestcomm DMA at all but PSC can
be used
in SPI mode with DMA. With DMA i can update display or read MMC block
with just one interupt without polling etc needed with normal SPI.


Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
