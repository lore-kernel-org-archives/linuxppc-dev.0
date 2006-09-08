Return-Path: <sachinp@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6193767B88
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 11:00:49 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8810jg8006935
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 21:00:45 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8810jhP324992
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 19:00:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8810jL4028951
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 19:00:45 -0600
Message-ID: <4500C0BA.8060408@in.ibm.com>
Date: Fri, 08 Sep 2006 06:30:42 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] kdump : Support kernels having 64k page size.
References: <44FE15B0.3030909@in.ibm.com>	
	<1157511577.3661.7.camel@localhost.localdomain>	
	<44FE6700.8080504@us.ibm.com>
	<1157590304.22705.267.camel@localhost.localdomain>
In-Reply-To: <1157590304.22705.267.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You should always do 64k regardless of the page size. I think we have
> some ABI requirements here for ELF sections to be 64k aligned anyway
> no ?
>
>   
Ben are you aware of any doc where i can find more information. I 
checked the
64Bit PowerPC ELF ABI doc but couldn't find any specific information about
this.

Also other question is  If we create a 64k segment irrespective of page size
[ as compared to 32k currently ] we would be writing extra 32k even for
page size of 4K. Which means we have 32k less memory for the kdump
kernel. Wouldn't that be an issue ?

Thanks
-Sachin
