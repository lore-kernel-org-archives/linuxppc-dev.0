Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07FCCDDEC5
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 09:03:09 +1000 (EST)
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4713AC4E.4050002@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com> <1190858397.11034.22.camel@pasglop>
	<4713AC4E.4050002@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 09:02:47 +1000
Message-Id: <1192489367.11795.48.camel@pasglop>
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


On Mon, 2007-10-15 at 22:07 +0400, Sergei Shtylyov wrote:
> > Proper approach is to rip off what is altready in -rt there and
> replace
> > it with Tony patch set.
> 
>     Tony's patchset is broken at places compared to what is in -rt. So
> that 
> would be proper *double standard* approach. :-/

Rather than tony patchset, can you look at what paulus has been
submitting, which should fix a few issues in tony initial patch and is
working, and tell us if you think something is still broken ?

Cheers,
Ben.
