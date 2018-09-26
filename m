Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L1DP0fGzzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:54:12 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8QEoC5B018398
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 10:54:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mrb8funpy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 10:54:08 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 26 Sep 2018 08:54:07 -0600
Subject: RESCIND Re: [v02] REPOST powerpc/migration: Handle unitialized timer
 reset
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, minkim@us.ibm.com,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <42KxfY2bFQz9s4Z@ozlabs.org>
 <3b78a11a-296e-00ac-3648-b26ce7c8aaac@linux.vnet.ibm.com>
Date: Wed, 26 Sep 2018 09:54:03 -0500
MIME-Version: 1.0
In-Reply-To: <3b78a11a-296e-00ac-3648-b26ce7c8aaac@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8816c05c-efc5-0b99-2de4-9cdf5480dd1a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael:
    I am an idiot this morning.  Not enough coffee.
I confused this posting with another.  Please forget the request.

    We do want to omit 

[PATCH v08 0/5] powerpc/hotplug: Update affinity for migrated CPUs
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/176301.html

though.

Very sorry for the inconvenience.

Michael

On 09/26/2018 09:44 AM, Michael Bringmann wrote:
> Hello, Michael:
>     Please look at v03 of the patch set which was posted
> just on 09/25/2018.  We had a last minute brainstorm of how
> to simplify the code after the v02 REPOST.
>     Also, note that we would like to invalidate the set,
> 
> [PATCH v08 0/5] powerpc/hotplug: Update affinity for migrated CPUs
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/176301.html
> 
> as we think it is covered now by other code.
> 
>     Thanks for your attention and assistance.
> 
> Michael
> 
> On 09/26/2018 07:13 AM, Michael Ellerman wrote:
>> On Thu, 2018-09-20 at 16:45:13 UTC, Michael Bringmann wrote:
>>> After migration of a powerpc LPAR, the kernel executes code to
>>> update the system state to reflect new platform characteristics.
>>> Such changes include modifications to device tree properties
>>> provided to the system by PHYP.  Property notifications received
>>> by the powerpc 'migration_store' code are passed along to the
>>> kernel in general through a call to 'of_update_property' which
>>> in turn passes such events back to all modules through entries like
>>> the '.notifier_call' function within the NUMA module.  When the
>>> NUMA module updates its state, it resets its event timer.  If this
>>> occurs after a previous call to 'stop_topology_update' or on a
>>> system without VPHN enabled, the code runs into an unitialized
>>> timer structure and crashes.  This patch adds a safety check
>>> along this path toward the problem code.
>>>
>>> Note: This crash was observed on every LPM in the 4.17-rc7 kernel
>>> (and in the 4.18 kernel) of a system with dedicated CPUs enabled.
>>> An example crash log without the patch is as follows.
>>>
>> ...
>>>
>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>
>> Applied to powerpc fixes, thanks.
>>
>> https://git.kernel.org/powerpc/c/8604895a34d92f5e186ceb931b0d1b
>>
>> cheers
>>
>>
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
