Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C8325DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:18:24 +1000 (EST)
Message-ID: <47176B39.1070300@ru.mvista.com>
Date: Thu, 18 Oct 2007 18:18:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
References: <1190345162.620000.305760830507.qpush@thor>
	<47162B6F.40903@ru.mvista.com>
In-Reply-To: <47162B6F.40903@ru.mvista.com>
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

Hello, I wrote:

>>With these functions implemented we cooperate better with the generic
>>timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

>     Aha, I'm seeing it's not merged to mainline yet!

    Contrarywise, it's been merged first -- looks like this all happened 
because of me not commenting on the patches in time... :-(
    Now one can only send incremental patches... sigh...

WBR, Sergei
