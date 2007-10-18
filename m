Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 84048DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:23:13 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so373661wag
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 15:23:12 -0700 (PDT)
Message-ID: <fa686aa40710181523l629a0226raa12ad447b45d78d@mail.gmail.com>
Date: Thu, 18 Oct 2007 16:23:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Alan Bennett" <alan@akb.net>
Subject: Re: driver using device trees, irqs, powerpc
In-Reply-To: <bfa0697f0710181519y261b41b1y46df293c61be344c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0710181519y261b41b1y46df293c61be344c@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Alan Bennett <alan@akb.net> wrote:
> Need help adding new driver to supports a custom FPGA.  Is there a
> good driver that anyone would recommend I can look at that is fully
> functional, works with 2.6.23 (powerpc style) and is described within
> a device tree?
>
> Bonus points:
>   uses freescale interrupts (timers/irq's from mpc 82xx/etc...)
>   isn't enet / cpm_uart (I've already looked at these)

Take a look at the xilinx device drivers.

drivers/block/xsysace.c
drivers/video/xilinxfb.c
driver/serial/uartlite.c

Each of these drivers support both platform bus and of_platform bus
(device tree).  All three are merged into Linus' mainline tree.

Cheers,
g.

>
> -Alan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
