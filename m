Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8DA0B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 07:51:26 +1000 (EST)
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Gusev <ronne@list.ru>
In-Reply-To: <4DE29B78.1070209@list.ru>
References: <4DE0AA62.4070909@list.ru>
	<BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
	<4DE29B78.1070209@list.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 May 2011 07:51:11 +1000
Message-ID: <1306705871.7481.594.camel@pasglop>
Mime-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-05-29 at 23:16 +0400, Andrey Gusev wrote:
> 28.05.2011 22:09, Tabi Timur-B04825 пишет:
> > On Sat, May 28, 2011 at 2:55 AM, Andrey Gusev<ronne@list.ru>  wrote:
> >> Hi!
> >> A kernel 2.6.39 doesn't boot on my POWER MAC G4.  A kernel 2.6.38.6 with
> >> almost the same config boots without any problems.
> > Have you tried using git-bisect to isolate the commit that breaks?
> >
> Fortunately, the rc1 is booted. I made git bisect:

> I have errors on building bad kernels:
> arch/powerpc/platforms/powermac/smp.c: In function ‘smp_core99_cpu_notify’:
> arch/powerpc/platforms/powermac/smp.c:855:7: error: 
> ‘pmac_tb_clock_chip_host’ undeclared (first use in this function)
> arch/powerpc/platforms/powermac/smp.c:855:7: note: each undeclared 
> identifier is reported only once for each function it appears in

This is an SMP machine ? If not, does it work with a UP kernel ?

Cheers,
Ben.
