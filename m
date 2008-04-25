Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8F892DE953
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 02:00:10 +1000 (EST)
Message-ID: <4811FFE4.2020203@ru.mvista.com>
Date: Fri, 25 Apr 2008 19:59:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: HR timers on PowerPC 83xx
References: <1209132039.31117.17.camel@gentoo-jocke.transmode.se>	
	<4811E845.2060509@ru.mvista.com>
	<1209135051.31117.19.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1209135051.31117.19.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:

>>>Trying to understand what is needed to make nanosleep() and friends to
>>>have better resolution than HZ on my 83xx CPU. Is this possible
>>>and what CONFIG options do I need to enable? Kernel is 2.6.25

>>    Should be possible with CONFIG_HIGH_RES_TIMERS=y.

> What about NO_HZ? Does that setting change anything?

    It is independent from HRT and selects the mode where the idle process 
stops timer HZ interrupts from occuring until it's scheduled off CPU.

WBR, Sergei
