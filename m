Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A8DF67B72
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:38:35 +1000 (EST)
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
In-Reply-To: <1155318983.5337.2.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	<17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	<yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	<1155318983.5337.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:38:07 +0200
Message-Id: <1155771487.11312.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You might take a peek at the patch set here:
> http://sr71.net/~jstultz/tod/ for a somewhat rough powerpc conversion to
> CONFIG_GENERIC_TIME.

Afaik, as-is, this patch will remove updating of the various bits used
by the vDSO for userland gettimeofday without actually removing the vdso
itself. Thus, with a recent glibc, it will break gettimeofday,
clock_gettime, .... Pretty bad :)

Ben.
