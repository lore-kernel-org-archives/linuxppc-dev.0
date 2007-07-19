Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54167DDF3D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 06:59:18 +1000 (EST)
In-Reply-To: <1184872216.16820.18.camel@ld0161-tx32>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
	<1184863497.16820.8.camel@ld0161-tx32>
	<5B45DD7F-1916-4E92-B0F6-6D1C11EF391B@kernel.crashing.org>
	<1184871420.16820.15.camel@ld0161-tx32>
	<20070719190215.GA30593@ld0162-tx32.am.freescale.net>
	<1184872216.16820.18.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2DD0B679-83C8-4D58-A9B3-258CD270DA3C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Date: Thu, 19 Jul 2007 15:59:44 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2007, at 2:10 PM, Jon Loeliger wrote:

> On Thu, 2007-07-19 at 14:02, Scott Wood wrote:
>
>> glib != glibc.
>>
>> -Scott
>
> D'oh.
>
> So, It doesn't say what version it is.
> But it is also dated 8-Apr-2003.

The glibc jdl tested against is 2.2.5.

- k
