Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59E6CDDEF9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:44:52 +1000 (EST)
Message-Id: <11BD2B27-0611-404B-AE5D-EC040913FA0B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?=22S=E9bastien_Chr=E9tien=22?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808290240o973f96ckdc85a134646e1378@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Advice : console
Date: Fri, 29 Aug 2008 04:44:44 -0500
References: <319b0ac50808290240o973f96ckdc85a134646e1378@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 29, 2008, at 4:40 AM, S=E9bastien Chr=E9tien wrote:

> Hello,
>
> I am trying to port linux for my ppc board. There is no keybord and =20=

> no scree. There is only UART.
> I would like to have a console/terminal using UART.
> What is the best way ? to write a serial driver using "struct  =20
> uart_driver" or using "tty_driver" or to write a driver from scratch.
> Maybe there is other way.

What powerpc chip is this?  Most of the current SoC based chips 4xx/=20
8xx/8xxx should have UART drivers in existence already.  If this is =20
something custom you are probably better of asking on the linux-kernel =20=

list this question since its not specific to PPC but just writing a =20
driver.

(and I'm guessing the answer is uart_driver, but I haven't looked at =20
what Alan Cox has been up to w/tty vs uart lately).

- k
