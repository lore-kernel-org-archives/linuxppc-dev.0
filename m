Return-Path: <minyard@acm.org>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [204.127.202.64])
	by ozlabs.org (Postfix) with ESMTP id 8DF1F2BDB5
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2004 09:07:55 +1100 (EST)
Message-ID: <41B0E3B4.8050006@acm.org>
Date: Fri, 03 Dec 2004 16:07:48 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41AF7DFC.9040009@acm.org>
	<20041202222349.GE14005@smtp.west.cox.net>
	<20041202154901.B20211@home.com> <41AF9E25.2080109@acm.org>
	<20041202231621.GF14005@smtp.west.cox.net>
In-Reply-To: <20041202231621.GF14005@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC debug setcontext  syscall implementation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>On Thu, Dec 02, 2004 at 04:58:45PM -0600, Corey Minyard wrote:
>
>  
>
>>I'll test gdb on classic and an ebony that I have.  I assume that gdb 
>>has a built-in test suite?
>>    
>>
>
>The GDB sources, yes.  You do need to build GDB first, have dejagnu
>installed and then run a 'make check'.  Ping me off-list if you want
>some help getting it all done.
>
>  
>
It checks out on 440gp and 7xx.  There were no differences in failures 
on the 7xx.  There was one difference on the 440gp, but that appeared to 
be a thread race condition and not related to this.

Thanks,

-Corey
