Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 888EDDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 05:39:45 +1000 (EST)
Message-ID: <46FAB56E.8080509@ru.mvista.com>
Date: Wed, 26 Sep 2007 23:39:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Steven Rostedt wrote:
> Tony,

> I'm about to release a new -rt patch based on -rc8. This patch series
> blew up totally in trying to get it applied. I'm leaving it out, so after
> I release the next series, could you update these patches.

    No wonder here: the -rt patch already has much of this code since around 
2.6.21.  They have been submitted by me, mostly... and this patchset is 
against the Linus' tree.

WBR, Sergei
