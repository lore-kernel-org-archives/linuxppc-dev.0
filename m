Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29CB0DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 12:00:40 +1000 (EST)
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46FAB56E.8080509@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 11:59:56 +1000
Message-Id: <1190858397.11034.22.camel@pasglop>
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


On Wed, 2007-09-26 at 23:39 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Steven Rostedt wrote:
> > Tony,
> 
> > I'm about to release a new -rt patch based on -rc8. This patch series
> > blew up totally in trying to get it applied. I'm leaving it out, so after
> > I release the next series, could you update these patches.
> 
>     No wonder here: the -rt patch already has much of this code since around 
> 2.6.21.  They have been submitted by me, mostly... and this patchset is 
> against the Linus' tree.

Proper approach is to rip off what is altready in -rt there and replace
it with Tony patch set.

Ben.
