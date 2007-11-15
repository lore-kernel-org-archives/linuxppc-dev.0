Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: printk/console_init - baud rate setting
Date: Wed, 14 Nov 2007 18:17:31 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73EAB@corpexc01.corp.networkrobots.com>
In-Reply-To: <610b1b49ca582c7a2277e8d6dea2be31@kernel.crashing.org>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
	<Pine.LNX.4.62.0711130915480.31003@pademelon.sonytel.be>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7F73D5F@corpexc01.corp.networkrobots.com>
	<72880d6da4c2ccb37ba665e420d26666@kernel.crashing.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7F73E14@corpexc01.corp.networkrobots.com>
	<610b1b49ca582c7a2277e8d6dea2be31@kernel.crashing.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Segher.

It was because of the BASE_BAUD value. We are working at 600MHz, not
18.432. After that change, it worked fine.

Thanks
Siva


-----Original Message-----
From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
Sent: Wednesday, November 14, 2007 3:00 PM
To: Siva Prasad
Subject: Re: printk/console_init - baud rate setting

> Thanks for your response Segher.

> I already have the command line "console=3DttyS0, 115200". Now, how to
> make sure that 115200 setting is calculated properly for the use by
> driver.
>
> In other words, can you kind enough to please let me know how 115200
is
> supported by the driver, based on the clock frequency.

That is solely the driver's own responsibility, you'll have to look
at the source code.  8250 typically just assumes 18.432MHz.


Segher
