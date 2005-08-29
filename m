Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B9FC6812D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2005 01:30:56 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j7TFUpO0136440
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:30:51 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP
	id j7TFUoQg063800
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 17:30:50 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j7TFUoDR029662
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 17:30:50 +0200
In-Reply-To: <f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
References: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
	<f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <873573479a451f5b7ac63763237a1c27@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 29 Aug 2005 17:31:20 +0200
To: Dan Malek <dan@embeddededge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> While ppc32 has the CONFIG_HZ Kconfig option, it wasnt actually being
>> used. Connect it up and set all platforms to 250Hz.  This pretty much
>> mimics the ppc64 patch from Anton Blanchard.
>
> Why do we keep cranking up this clock frequency?  Do we really need
> it running that fast?  Is it time for someone with RTOS experience to
> implement a real scheduled clock queue in Linux instead of just
> wasting interrupts decrementing a counter waiting for the next
> event to expire?  :-)

Sure.  And some people are actually working on that.  But
on common x86 hardware, it seems to be a really really hard
thing to do.  Would be a lot easier in PowerPC of course...


Segher
