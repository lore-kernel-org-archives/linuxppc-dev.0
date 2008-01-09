Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 09DBEDDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:34:25 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so336025rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:34:23 -0800 (PST)
Message-ID: <5c9cd53b0801090734t56c0c64lf29d748777c57894@mail.gmail.com>
Date: Wed, 9 Jan 2008 10:34:23 -0500
From: "mike zheng" <mail4mz@gmail.com>
To: "Haiying Wang" <Haiying.Wang@freescale.com>
Subject: Re: printk() does not work on UART1
In-Reply-To: <1199888068.3004.3.camel@udp097527uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0801081611ve59e9a8q6ae2fd227bfc0ed8@mail.gmail.com>
	<5c9cd53b0801082106p7b57e11ejc809c182a26599d5@mail.gmail.com>
	<1199888068.3004.3.camel@udp097527uds.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I found the problem. The CONFIG_CMDLINE was overwritten. Right now, it
is working.

Thanks for all the help,

Mike


On 1/9/08, Haiying Wang <Haiying.Wang@freescale.com> wrote:
> On Wed, 2008-01-09 at 00:06 -0500, mike zheng wrote:
> >  Hi All,
> >
> >  I have one mpc8568 board using UART1 as the serial port.  The OS is
> >  Linux Kernel2.4.  If I use the polling mode driver of
> >  gen550_progress(), it works fine. However the printk() does not work
> >  after the console_init(). Anyone know what shall I change in the
> >  kernel to use UART1 as serial console? I assume the default is UART0,
> >  but I don't know where the value is set. I changed the CONFIG_CMDLINE
> >  to ttyS1, it does NOT work.
>
> Make sure you've configured PC0/1/2/3 for UART1 SOUT/RTS/CTS/SIN in
> u-boot.
>
> Haiying
>
>
