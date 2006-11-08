Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 871E767C47
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 01:22:00 +1100 (EST)
Message-ID: <4551E7FF.8010209@ru.mvista.com>
Date: Wed, 08 Nov 2006 17:21:51 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
References: <200611080005.08633.sshtylyov@ru.mvista.com>	<1162938997.28571.534.camel@localhost.localdomain>	<45510C58.3010707@ru.mvista.com>
	<17745.14911.693171.717979@cargo.ozlabs.ibm.com>
In-Reply-To: <17745.14911.693171.717979@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: tglx@linutronix.de, greg.weeks@timesys.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>    Arch-specific accounting hooks which this feature makes use of can't be 
>>called from the generic clockevents code.

> Which hooks specifically?

    You aren't saying you don't know your own code?
    Specifically, it's local account_process_time() function being called 
instead of updated_process_times() with CONFIG_VIRT_CPU_ACCOUNTING option on.

> The deterministic accounting is an essential feature; there's no way
> I'll accept a patch which disables it.

    I'm not talking you into accepting it in any way, this is just to keep 
people informed.
    And I left people a choice: they can either have fancy accounting or HRT, 
just not both at once. What's wrong with that?

> Paul.

WBR, Sergei
