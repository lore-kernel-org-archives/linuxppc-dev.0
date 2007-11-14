Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42595DDDD6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 03:21:24 +1100 (EST)
In-Reply-To: <bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
	<bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: I2C on mpc8248 / device tree
Date: Wed, 14 Nov 2007 10:20:42 -0600
To: "Alan Bennett" <embedded@akb.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch is orthogonal to your issue.

There is NOT a driver in the kernel tree for the i2c on CPM2 based  
parts like the 8248 (from what I can tell).

- k

On Nov 14, 2007, at 9:31 AM, Alan Bennett wrote:

> Does this patch support the cpm2 as well?
>
> I get conflicting thoughts looking over the latest postings.
>
> -Alan
>
>
> On 11/13/07, Jon Smirl < jonsmirl@gmail.com> wrote:I am working on  
> a patch for i2c and device tree. I attached the current version.
>
> DTC entry looks like this.
>
>                 i2c@3d40 {
>                         compatible = "mpc5200b-i2c","mpc5200- 
> i2c","fsl-i2c";
>                         reg = <3d40 40>;
>                         interrupts = <2 10 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>                         fsl5200-clocking;
>
>                         rtc@51f {
>                                 compatible = "epson,rtc8564";
>                                 reg = <51>;
>                         };
>                 };
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
