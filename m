Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-05.nyroc.rr.com (ms-smtp-05.nyroc.rr.com [24.24.2.59])
	by ozlabs.org (Postfix) with ESMTP id 5072ADDEE6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 05:45:05 +1000 (EST)
Date: Wed, 26 Sep 2007 15:44:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
In-Reply-To: <46FAB56E.8080509@ru.mvista.com>
Message-ID: <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--
On Wed, 26 Sep 2007, Sergei Shtylyov wrote:

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

That would explain it ;-)

I was searching the linux-rt-users mailing list for any patches, and
pulled in any that looked legit. These happen to in that mailing list too.

-- Steve
