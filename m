Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F17C8DDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 19:41:02 +1000 (EST)
Message-ID: <48DB50C6.3030003@linutronix.de>
Date: Thu, 25 Sep 2008 10:50:14 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
References: <20080923195404.GA10935@www.tglx.de>
	<F7E012CB-5062-496D-BECC-4B9EAFBD4D75@kernel.crashing.org>
In-Reply-To: <F7E012CB-5062-496D-BECC-4B9EAFBD4D75@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I missing why you are doing this?  Do you plan on using it w/32-bit kexec?

Yes. I plan to kexec my mpc8544 board.

> 
> - k
Sebastian
