Return-Path: <jschopp@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F0CEB6F19
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 05:15:43 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBLI7xrJ030985
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 11:07:59 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nBLIFX4H100132
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 11:15:35 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBLIFWp1031453
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 11:15:32 -0700
Message-ID: <4B2FBB3F.8030703@austin.ibm.com>
Date: Mon, 21 Dec 2009 12:15:27 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
References: <1261170452.8134.13.camel@jschopp-laptop>
	<29526.1261353566@neuling.org>
In-Reply-To: <29526.1261353566@neuling.org>
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


>> Subject: Re: [PATCH] powerpc: update ibm,client-architecture
>>     
>
> Please give this a more appropriate name.  
>   
Any suggestions?
>   
>> In order to boot with more than 64 cores on machines that support the
>> ibm,client-architecture RTAS call a new field has been added to the
>> structure.  This patch updates that field and adds a few others in the
>> process.
>>     
>
> Please detail what these are here.
>   
OK.
>> +	W(NR_CPUS/4),			/* max cores supported */
>>     
>
> 4?
>
>   
4 is the new 2.  Since you don't know the actual threads per core at 
this point in boot you have to be conservative and go with the maximum 
number of any processor.  See page 4 of these charts:
http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf
>
>
> Can we do this now or remove the comment.  Maybe UTS_RELEASE or
> something like that.
>   
I'll just remove the comment for now.
