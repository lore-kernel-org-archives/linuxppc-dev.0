Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83A4AB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 15:32:53 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33F9BDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 15:32:52 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8A5SPKr029602
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 15:28:25 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8A5Uu0d1470468
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 15:30:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8A5WmpR028288
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 15:32:48 +1000
Message-ID: <4AA88F7D.5030302@in.ibm.com>
Date: Thu, 10 Sep 2009 11:02:45 +0530
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
In-Reply-To: <1252525364.27001.32.camel@gandalf.stny.rr.com>
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
> Ah, seems the bug happens to be in the module handling. Does the call
> back always have .mod_return_to_handler?
>   
Yes. Every time it ends up in .mod_return_to_handler

Thanks
-Sachin

> This doesn't surprise me any. The module code is a bit harry, and
> function graph does some crazy crap with it.
>
> -- Steve
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
