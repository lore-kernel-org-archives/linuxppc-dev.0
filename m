Return-Path: <sachinp@in.ibm.com>
Received: from e28esmtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6CC3DDF10
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 19:20:42 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6V9KZ3c018757
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:50:35 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6V9KZLd1065136
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:50:35 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6V9KZPo032380
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:50:35 +0530
Message-ID: <489183D4.5060605@in.ibm.com>
Date: Thu, 31 Jul 2008 14:50:20 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/kdump: Fix /dev/oldmem interface
References: <489161A4.6060801@in.ibm.com> <1217488357.1487.51.camel@localhost>
In-Reply-To: <1217488357.1487.51.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Heh, do I get a prize for being neurotic? ;)  .. Or just stupid, ahem.
>
> I think you should also sign off on it Sachin, see clause (c) of the
> developers cert (http://lwn.net/Articles/139918/)
>
>   
Here is a signed-off from me. Let me know if i need to resubmit
the patch with all signed-off-by lines.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>


-- 
Thanks
-Sachin

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
