Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F080BDDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 11:19:23 +1000 (EST)
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4713ABDA.2000506@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
	<Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
	<1190836713.23376.41.camel@chaos>  <4713ABDA.2000506@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 11:19:03 +1000
Message-Id: <1192497543.19073.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>    Eh... poor you. Tony got clockevent driver reengineered for no apparent 
> reason.  And he's introduced the jiffy drift by deleting the main loop from 
> timer_interrupt(). Yet this borken version was preferred to what was known 
> working since about 2.6.18 and included into 2.6.21-rt patchset.  I don't like 
> that policy. Will you be pushing fixes from -rt to PowerPC, or will it fall on 
> my shoulders now?

Possibly because whatever implementation existed before was never
provided in a mergeable form and pushed to -rt bypassing the powerpc
architecture maintainer ?

Ben.
