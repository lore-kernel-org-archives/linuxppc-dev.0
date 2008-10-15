Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 954FDDDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 19:59:12 +1100 (EST)
Date: Wed, 15 Oct 2008 10:59:04 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Message-ID: <20081015085904.GA28369@Chamillionaire.breakpoint.cc>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20081014224946.GA2503@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Sebastian Andrzej Siewior | 2008-10-15 00:49:46 [+0200]:

>>is the -mabi=no-spe really needed?
>It seems to work the other way around (without -mabi=no-spe but with
>-mabi=no-spe) alteast I did not find anything in do_syslog() or while
>browsing through the dissasm. I do a boot check tomorrow.

Okay. I recompiled with -mspe=no and was able to boot without trouble.
It didn't work with -mabi=no-spe.

>>
>>- k

Sebastian
