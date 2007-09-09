Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18147.49943.182399.64990@cargo.ozlabs.ibm.com>
Date: Sun, 9 Sep 2007 19:55:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
In-Reply-To: <20070907082143.GA27058@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<20070906170123.GA17990@ld0162-tx32.am.freescale.net>
	<20070906170547.GA12432@iram.es>
	<20070906172415.GA18226@ld0162-tx32.am.freescale.net>
	<20070907082143.GA27058@iram.es>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert writes:

> The solution now used by i386/x86-64/sparc64 is
> CONFIG_GENERIC_CMOS_UPDATE. Maybe powerpc should be switched
> to use something similar, but the generic code has some

Yes.  I'll turn on CONFIG_GENERIC_CMOS_UPDATE.  Do you think it needs
to be a config option that can be turned on and off in the kernel
config, or should it just be always on as on x86[-64]?

> problems (it assumes that you have to set the clock
> on a half-second, which is not the case of the RTC on 
> my boards to start with).

Let's get the generic code fixed to do what we need then.  Care to
send a patch?

Paul.
