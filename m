Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8613DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 04:50:49 +1100 (EST)
Date: Wed, 18 Mar 2009 12:50:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mark Bishop <mark@bish.net>
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
Message-ID: <20090318175032.GA3410@loki.buserror.net>
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
	<20090311120300.atgtikpneo0gos0w@www.bish.net>
	<20090311165320.GB11120@ld0162-tx32.am.freescale.net>
	<20090311142708.olkbrtn5hws0cg8w@www.bish.net>
	<f234e2140903152241i7a8b4c39jd4b4f5935bffed3e@mail.gmail.com>
	<20090317125252.rqhc78q90k0wsoww@www.bish.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090317125252.rqhc78q90k0wsoww@www.bish.net>
Cc: Vijay Nikam <vijay.t.nikam@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2009 at 12:52:52PM -0400, Mark Bishop wrote:
> Quoting Vijay Nikam <vijay.t.nikam@gmail.com>:
>
>> Hi Mark,
>>
>> Could you please let me know how you booted the latest Linux kernel on
>> MPC8313ERDB board ? ? ? As I tried but was not successful. It hangs or
>> does nothing and waits at network configuration, mean to determine IP
>> address (as I have used dhcp).
>>
>> Kindly please acknowledge ... thank you ...
>>
>> Kind Regards,
>> Vijay Nikam
>>
>>
>
> I modified the .dts file (mpc8313erdb.dts)
>
> WAS interrupts = <37 0x8 36 0x8 35 0x8>;
> IS  interrupts = <34 0x8 33 0x8 32 0x8>;

Should actually be <32 8 33 8 34 8> for newer revs.

> WAS interrupts = <34 0x8 33 0x8 32 0x8>;
> IS  interrupts = <37 0x8 36 0x8 35 0x8>;

Likewise, <35 8 36 8 37 8>.

-Scott
