Return-Path: <jonmasters@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id 104092BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 23:57:35 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 76so116999rnk
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 06:57:33 -0700 (PDT)
Message-ID: <35fb2e5904102506574d6c7470@mail.gmail.com>
Date: Mon, 25 Oct 2004 14:57:30 +0100
From: Jon Masters <jonmasters@gmail.com>
To: grave <grave@ipno.in2p3.fr>
In-Reply-To: <1098701468l.31592l.0l@ipnnarval>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1098701468l.31592l.0l@ipnnarval>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 25 Oct 2004 10:51:08 +0000, grave <grave@ipno.in2p3.fr> wrote:

> We re starting a disign with xilinx chip Virtex II pro and I wonder the
> typical size of an uboot binary. This is for our electronician disigner
> in order to dimension the prom and so on...

It might be worth asking your electronics people whether they're going
to use the Xilinx SysACE chip in your hardware design. If this is the
case then you can program the Virtex and load in the kernel and
bootloader from Compact Flash. I don't know whether uboot supports
this out of the box since I wrote my own Virtex II bootloader, but it
should be quite doable.

Certainly you really want to avoid PROMs in the design if at all
possible - with our design it's possible for us to swap out a CF and
in one step replace all hardware and software, upgrading is a case of
sending the customer a loopback mountable filesystem which reloads the
CF after the customer downloads the "firmware update" via a web page.

Cheers,

Jon.
