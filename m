Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1BC6067DA2
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 01:08:50 +1100 (EST)
Message-ID: <455487E2.9040701@ru.mvista.com>
Date: Fri, 10 Nov 2006 17:08:34 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
References: <200611080005.08633.sshtylyov@ru.mvista.com>	<1162938997.28571.534.camel@localhost.localdomain>	<45510C58.3010707@ru.mvista.com>	<17745.14911.693171.717979@cargo.ozlabs.ibm.com>	<4551E7FF.8010209@ru.mvista.com>
	<17748.14621.231956.561842@cargo.ozlabs.ibm.com>
In-Reply-To: <17748.14621.231956.561842@cargo.ozlabs.ibm.com>
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
> Sergei Shtylyov writes:

>>    And I left people a choice: they can either have fancy accounting or HRT, 
>>just not both at once. What's wrong with that?

> _I_ want both at once. :)

    I think the usual rule is: "you want it, you do it". ;-)

    Seriously, we have neither time, not hardware, nor docs for the h/w this 
accounting option applies to. And coercing the generic clcokevents/hrtimers 
code into calling the arch hooks is serious design decision which I felt is 
better to be left to Thomas as a maintainer...

> Paul.

WBR, Sergei
