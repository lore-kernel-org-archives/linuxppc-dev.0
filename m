Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 12238B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 14:27:08 +1000 (EST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 165A2DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 14:27:06 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8B4R00v011763
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 09:57:00 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8B4R0in2531412
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 09:57:00 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8B4R0jY002690
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 09:57:00 +0530
Message-ID: <4AA9D193.9030304@in.ibm.com>
Date: Fri, 11 Sep 2009 09:56:59 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: rostedt@goodmis.org
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252525364.27001.32.camel@gandalf.stny.rr.com>
	<4AA88F7D.5030302@in.ibm.com>
	<1252638353.18996.62.camel@gandalf.stny.rr.com>
In-Reply-To: <1252638353.18996.62.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Thu, 2009-09-10 at 11:02 +0530, Sachin Sant wrote:
>   
>> Steven Rostedt wrote:
>>     
>>> Ah, seems the bug happens to be in the module handling. Does the call
>>> back always have .mod_return_to_handler?
>>>   
>>>       
>> Yes. Every time it ends up in .mod_return_to_handler
>>     
>
> BTW, do you have CONFIG_IRQSTACK set?
>   
Yes. That option is enabled.

CONFIG_DEBUGGER=y
CONFIG_IRQSTACKS=y
# CONFIG_VIRQ_DEBUG is not set

thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
