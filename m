Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3159DB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 20:40:17 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28D68DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 20:40:15 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n73Ae212012436
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 16:10:02 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73Ae2Cj1126420
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 16:10:02 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n73Ae1iY015966
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 16:10:02 +0530
Message-ID: <4A76BE81.4080707@in.ibm.com>
Date: Mon, 03 Aug 2009 16:10:01 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
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
> Thanks,
>
> I've seen issues with my PPC box and function graph, but the bugs were
> also caused by other changes. I'll boot up my PPC64 box and see if
> I see the same issues you have.
>   
Hi Steven,

I can still recreate this issue with 2.6.31-rc5. Let me know
if i can provide any information to find a solution for this.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
