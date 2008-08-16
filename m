Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C2F03DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 22:56:45 +1000 (EST)
Message-ID: <48A6CE85.2060207@denx.de>
Date: Sat, 16 Aug 2008 14:56:37 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: yanlong wang <killyouatonce@gmail.com>
Subject: Re: How to use ttyUL0 as input and use VGA as display?
References: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
In-Reply-To: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

yanlong wang wrote:

>      I port the linux on my ml300 board , the system is work well. But
> have some small problem.
>     I want use  serial port as input device  and use VGA as display.
>     How i set the console parameter?
>     If i set console like this " console=ttyUL0,9600 console=tty0
> root=/dev/ram". The boot message display on both of  serial port and
> VGA. But when the system come to the "sh".There is no output on ttyUL0
> ,.All message display on the VGA , then £Écann't input command by
> serial port .
>     How to slove this probelm?

Did you try to pass ttyUL0 after tty0?
Try "root=/dev/ram console=tty0 console=ttyUL0,9600".

Best regards,
Anatolij
