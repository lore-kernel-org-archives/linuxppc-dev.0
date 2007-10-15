Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5C2ABDDF56
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:06:58 +1000 (EST)
Message-ID: <4713AC4E.4050002@ru.mvista.com>
Date: Mon, 15 Oct 2007 22:07:10 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
References: <1190345162.620000.305760830507.qpush@thor>	
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>	
	<46FAB56E.8080509@ru.mvista.com>
	<1190858397.11034.22.camel@pasglop>
In-Reply-To: <1190858397.11034.22.camel@pasglop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>>>I'm about to release a new -rt patch based on -rc8. This patch series
>>>blew up totally in trying to get it applied. I'm leaving it out, so after
>>>I release the next series, could you update these patches.

>>    No wonder here: the -rt patch already has much of this code since around 
>>2.6.21.  They have been submitted by me, mostly... and this patchset is 
>>against the Linus' tree.

> Proper approach is to rip off what is altready in -rt there and replace
> it with Tony patch set.

    Tony's patchset is broken at places compared to what is in -rt. So that 
would be proper *double standard* approach. :-/

> Ben.

WBR, Sergei
