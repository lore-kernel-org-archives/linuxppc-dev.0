Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 2F7662BDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Nov 2004 12:50:31 +1100 (EST)
Message-ID: <41898ADC.5080707@vision.caltech.edu>
Date: Wed, 03 Nov 2004 17:50:20 -0800
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <41893BFB.1010903@vision.caltech.edu>
	<1099522581.31629.84.camel@gaston>
In-Reply-To: <1099522581.31629.84.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 
Subject: Re: printk problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Wed, 2004-11-03 at 12:13 -0800, Arrigo Benedetti wrote:
>  
>
>>For some reason I can't get printk() to work on a YDL 4.0 system. I have 
>>followed all the instructions, like
>>setting the correct log level in /proc/sys/kernel/printk, killing klogd 
>>and then
>>
>>cat /proc/kmsg
>>
>>but I do not see any message from printk. The printk is in a new kernel 
>>system call that I wrote.
>>Any ideas?
>>    
>>
>
>Are you sure you are reaching your syscall at all ? Besides, why are you
>adding a syscall in the first place ? (just curious ... it's usually the
>wrong solution :)
>
>  
>

I'm pretty sure that the syscall is called, in fact at some point there 
was a bug in the code which
froze the system... I made a syscall just to do some quick timing tests. 
I agree that a module is a
better solution, and in fact I have just posted a message about that...

-Arrigo
