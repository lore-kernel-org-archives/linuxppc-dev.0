Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id 6B0B8DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 03:37:22 +1100 (EST)
Message-ID: <20090317125252.rqhc78q90k0wsoww@www.bish.net>
Date: Tue, 17 Mar 2009 12:52:52 -0400
From: Mark Bishop <mark@bish.net>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
	<20090311120300.atgtikpneo0gos0w@www.bish.net>
	<20090311165320.GB11120@ld0162-tx32.am.freescale.net>
	<20090311142708.olkbrtn5hws0cg8w@www.bish.net>
	<f234e2140903152241i7a8b4c39jd4b4f5935bffed3e@mail.gmail.com>
In-Reply-To: <f234e2140903152241i7a8b4c39jd4b4f5935bffed3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Vijay Nikam <vijay.t.nikam@gmail.com>:

> Hi Mark,
>
> Could you please let me know how you booted the latest Linux kernel on
> MPC8313ERDB board ? ? ? As I tried but was not successful. It hangs or
> does nothing and waits at network configuration, mean to determine IP
> address (as I have used dhcp).
>
> Kindly please acknowledge ... thank you ...
>
> Kind Regards,
> Vijay Nikam
>
>

I modified the .dts file (mpc8313erdb.dts)

WAS interrupts = <37 0x8 36 0x8 35 0x8>;
IS  interrupts = <34 0x8 33 0x8 32 0x8>;

WAS interrupts = <34 0x8 33 0x8 32 0x8>;
IS  interrupts = <37 0x8 36 0x8 35 0x8>;

This is from memory, so let me know if you have a problem.

And sorry for the manual diff.



Any idea on how to get spidev up and running on this board?  :)
