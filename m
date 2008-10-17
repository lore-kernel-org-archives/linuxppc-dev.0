Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4819BDDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 01:02:31 +1100 (EST)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <20081015144359.GA30649@Chamillionaire.breakpoint.cc>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
	<20081015144359.GA30649@Chamillionaire.breakpoint.cc>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 09:02:11 -0500
Message-Id: <1224252131.7879.117.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 16:43 +0200, Sebastian Andrzej Siewior wrote:
> With this patch it compiles and boots fine.
> The option -mabi=no-spe is not required.

Please don't accept this patch yet.  My past testing showed that
"-mabi=no-spe" was required for my toolchain.  I'll go back and double
check though.

- Nate Case <ncase@xes-inc.com>
