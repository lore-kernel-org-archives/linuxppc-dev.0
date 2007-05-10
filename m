Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 092EEDDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 00:23:19 +1000 (EST)
Message-ID: <4643630F.5030505@ru.mvista.com>
Date: Thu, 10 May 2007 18:23:11 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
References: <20070510123950.7984.24745.stgit@localhost.localdomain>
	<1178800722.22802.12.camel@zod.rchland.ibm.com>
In-Reply-To: <1178800722.22802.12.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	wli@holomorphy.com, pavel@ucw.cz, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

>On Thu, 2007-05-10 at 12:39 +0000, Maxim Uvarov wrote:
>  
>
>>Patch makes available to the user the following
>>task and process performance statistics:
>>	* Involuntary Context Switches (task_struct->nivcsw)
>>	* Voluntary Context Switches (task_struct->nvcsw)
>>	* Number of system calls (added new counter
>>	  thread_info->sysall_count)
>>	           
>>Statistics information is available from:
>>        1. taskstats interface (Documentation/accounting/)
>>	2. /proc/PID/status (task only).
>>
>>This data is useful for detecting hyperactivity
>>patterns between processes.
>>    
>>
>
>This should be sent to the linux-kernel list I think...  Or at least
>CCd.
>
>  
>
Thanks,  It is interesting but I can not Cc message to  linux-kernel.
Only sending directly works (To:).

Link is here:
http://lkml.org/lkml/2007/5/10/289

>josh
>
>  
>
