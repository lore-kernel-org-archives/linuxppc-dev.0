Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDCA42BD81
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 22:07:08 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
In-Reply-To: <16753.1940.232184.119064@alkaid.it.uu.se>
References: <16752.64288.975262.790788@alkaid.it.uu.se>
	<1097925801.8965.42.camel@gaston>
	<16753.1940.232184.119064@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1097928230.8965.44.camel@gaston>
Mime-Version: 1.0
Date: Sat, 16 Oct 2004 22:03:51 +1000
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 745x coherency fix for 2.4?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The cputable.c change adds CPU_FTR_NEED_COHERENT to all CPUs when
> CONFIG_SMP is set. That's why the changes from #ifdef CONFIG_SMP
> to checking this feature flag work for both SMP and 745x.
> 
> The logic is straight from the 2.6 kernel; I only adapted it where
> the 2.4 kernel was different, like some of the cputable entries
> were missing in 2.4.

Ok, good then. I'll CC to Marcelo

Ben.
