Return-Path: <michael@evidence.eu.com>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A65E0DE9B3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 02:17:35 +1000 (EST)
Message-ID: <49EF4201.9030606@evidence.eu.com>
Date: Wed, 22 Apr 2009 18:12:49 +0200
From: michael <michael@evidence.eu.com>
MIME-Version: 1.0
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>	<200904221602.29028.ossrosch@linux.vnet.ibm.com>	<49EF254A.6020106@evidence.eu.com>
	<200904221800.41399.ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200904221800.41399.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Roland Dreier <rdreier@cisco.com>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Stefan Roscher wrote:
> On Wednesday 22 April 2009 04:10:18 pm michael wrote:
>   
>> Hi,
>>
>>     
>
>   
>> I don't take the point, if it is not import use the vmalloc. Why you try 
>> with a kmalloc
>> alloc first? and why do not use kzalloc?
>>     
>
> Because kmalloc() is faster than vmalloc() causing a huge performance win
> when someone allocates a large number of queue pairs. We fall back to
> vmalloc() only if kmalloc() can't deliver the memory chunk.
>   
Sorry I catch later the performace issue.
> We don't need kzalloc because we fill the list right after the alloc.
>
> regards Stefan
>   
Regards Michael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
