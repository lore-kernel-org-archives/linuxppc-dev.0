Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0684BDDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 03:42:10 +1000 (EST)
In-Reply-To: <46F93E54.5050203@gmail.com>
References: <46F93E54.5050203@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A9ADFCB-2725-4156-BE66-4E55A4987E2D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Book-E watchdog driver questions
Date: Tue, 25 Sep 2007 12:42:04 -0500
To: Mike Nuss <mikenuss@gmail.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 11:59 AM, Mike Nuss wrote:

> Hi,
>
> I have a PPC440EPx and I am testing out the builtin watchdog. I have a
> couple of questions:
>
> Is there a reason that booke_wdt.c does not specify a MODULE_LICENSE?
>> From the copyright notice at the top it appears to be GPL. As  
>> written,
> it taints the kernel.

Odd, no reason.  I'll submit a patch for that.

> Also, if I test out the driver by killing my process that's doing the
> pinging, I get a kernel panic:

Its been a while since i've tried this.  I'll try it out and see what  
happens.

- k
