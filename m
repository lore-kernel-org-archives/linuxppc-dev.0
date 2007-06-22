Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D5244DDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 22:40:22 +1000 (EST)
Message-ID: <467BC398.1000506@ru.mvista.com>
Date: Fri, 22 Jun 2007 16:42:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [RFC] clocksouce implementation for powerpc
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>
	<1182009083.11539.369.camel@imap.mvista.com>
	<20070620065710.GR9768@bakeyournoodle.com>
	<46795B9B.2020401@ru.mvista.com>
	<20070622061047.GW9768@bakeyournoodle.com>
In-Reply-To: <20070622061047.GW9768@bakeyournoodle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
	john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:

> 	Thanks for taking the time to look over my patch.

>>   I guess it's been based on the prior work by John Stultz (and me too :-)?

> At some level I guess so.  John did send me a patch a while ago.

>>   If you mean the init. part, this has been already done by me -- I've 
>>implemented read_persistent_clock() and got rid of xtime setting. What's 
>>left is to implemet update_persistent_clock() and get rid of 
>>timer_check_rtc()...

> Actually I think that comment is redundant.  and should be removed
> sorry.

    I guess you haven't looked thru the -rt patch? There's much more than 
John's initial patch there now, including the clockevents driver.

>>>+	.mult         = 0,	/* To be filled in */
>>>+	.read         = NULL,   /* To be filled in */
>>>+	.settimeofday = NULL,   /* To be filled in */
>>
>>   I don't quite understand why not just init them right away?  The values 
>>are fixed anyways.

> Well at least mult needs to be calculated at runtime, and I prefer to

    I was talking about the method intializers specifically.

> have the structure near the top of the file at which stage the
> read/settimeofday functions aren't defined.

    I don't think it's justified anyway.

> Yours Tony

WBR, Sergei
