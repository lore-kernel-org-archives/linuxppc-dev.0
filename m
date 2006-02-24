Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id C7E7367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 03:48:24 +1100 (EST)
Date: 24 Feb 2006 16:48:21 -0000
Message-ID: <20060224164821.8917.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: lijianggan@pmail.ntu.edu.sg, linuxppc-embedded@ozlabs.org
Subject: Re: boot failure on lite5200b board
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
	<84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>From article <84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>:
> I have actually tried both kernel with both console configurations. It =
> gave the same output, thus I presume that the problem lies somewhere =
> else. I attached the log to this email.=20
> 
> the board is Lite5200B Version 1.0. Which .config file do you want?
> 
> Sylvain, we have ordered a debugging set but we are still waiting for =
> delivery, the leaking time is said to be one month, tant pis. And the =
> log I attached here are booting from a higher address (0x500000).
> 
> My current u-boot args:
> 
> setconsole=setenv bootargs console=ttyPSC0, 115200n8 console=tty1

This is incorrect.  There can be no space before the baud rate,
and I don't think you want console=tty1.

-Dale
