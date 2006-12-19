Return-Path: <minyard@acm.org>
Received: from mta16.adelphia.net (mta16.mail.adelphia.net [68.168.78.211])
	by ozlabs.org (Postfix) with ESMTP id 4CA26DDF4B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 05:01:58 +1100 (EST)
Message-ID: <45882913.2000609@acm.org>
Date: Tue, 19 Dec 2006 12:01:55 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
	<20061219141245.679caa11@localhost>
	<33A5A5AA-3ECF-474E-90D4-584EEA7F37AD@kernel.crashing.org>
In-Reply-To: <33A5A5AA-3ECF-474E-90D4-584EEA7F37AD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@linux.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> info->io_regsize = regsize ? *regsize : DEFAULT_REGSIZE;
>>>
>>> [Please note that fixes a copy/paste bug, too].
>>
>> There is no DEFAULT_REGSIZE, all the code is using DEFAULT_REGSPACING 
>> as the default size.
>> It looks like the code assumes that the registers are located next to 
>> each other.
>
> It would be more logical to only use REGSIZE then, heh.
>
>> If thats not good, DEFAULT_REGSIZE should be introduced and used in 
>> all other probe functions as well.
>> That would be a seperate issue .
>
> You could start the cleanup by doing
>
> #define DEFAULT_REGSIZE DEFAULT_REGSPACING
>
> and using REGSIZE in the new code.  Or replace s/REGSPACING/REGSIZE/
> throughout.  Or something.
>
> Not your fault though, just leave it as-is if you don't feel
> like fixing others' mess :-)
Doing this is fine with me, it needs to be done.

-Corey
