Message-ID: <3E37D18D.7080900@imc-berlin.de>
Date: Wed, 29 Jan 2003 14:05:17 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC with MPC8xx?
References: <20030129124938.4338CC608E@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk schrieb:
> In message <3E37CB15.50307@imc-berlin.de> you wrote:
>
>>what do I have to do to use an I2C RTC (like Dallas DS1337) within LinuxPPC?
>
> Use drivers/i2c/i2c-algo-8xx.c and add your own version of
> drivers/i2c/i2c-ds1337.c ?
Hmm. But there must be at least one excample!?
Someone must have done that before!?
After all I don't want to reinvent the wheel... (Ooh, how much I love that
phrase!) :o)

>>I know there're drivers for PPCBoot / U-Boot.
>
>
> There are also drivers for Linux.
I bet there are drivers for Linux!
How else should all the people using PPCBoot/U-Boot and I2C RTCs on MPC8xx
platforms access them from Linux...

But where could I find one? Isn't LWMON using an I2C RTC? But I just can't find
the driver...

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
