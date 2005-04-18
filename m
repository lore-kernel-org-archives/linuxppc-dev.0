Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 8F24B67A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 05:54:24 +1000 (EST)
Message-ID: <42641069.80008@mvista.com>
Date: Mon, 18 Apr 2005 12:54:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050415022430.52080.qmail@web15806.mail.cnb.yahoo.com>
In-Reply-To: <20050415022430.52080.qmail@web15806.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam,

Sorry for the delay, I was on vacation last week.
--

Sam Song wrote:

><snip>
>

>--- Sam Song <samlinuxppc@yahoo.com.cn> wrote:
>

><snip>
>

>>I created one image only with 8250 serial and
>>RAMDISK support kernel. The console setting was
>>"ttyS0,115200". But hanged after loading the 
>>kernel... What could the problem be?
>>    
>>
>
>Still no luck. From the print message I set, it passed
>MMU_init() and mpc10x_bridge_init(), then stopped.
>
>Any clue on it?
>

It could be lots of things. Can you dump __log_buf? If so, please dump
and send it so we can have a look. If not, try adding more progress
stmts and telling us exactly where its stopping.

Mark
