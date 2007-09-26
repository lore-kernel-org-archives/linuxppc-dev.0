Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 58230DDE9D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 05:58:40 +1000 (EST)
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
	<Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 21:58:33 +0200
Message-Id: <1190836713.23376.41.camel@chaos>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-26 at 15:44 -0400, Steven Rostedt wrote:
> >     No wonder here: the -rt patch already has much of this code since around
> > 2.6.21.  They have been submitted by me, mostly... and this patchset is
> > against the Linus' tree.
> 
> That would explain it ;-)
> 
> I was searching the linux-rt-users mailing list for any patches, and
> pulled in any that looked legit. These happen to in that mailing list too.

I'll sort that out along with the other hrt updates.

	tglx
