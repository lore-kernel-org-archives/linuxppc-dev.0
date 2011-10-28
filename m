Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 55E8B1007DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 16:03:21 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
 by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9S53GJc029728
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 16:03:16 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9S53F7s2207978
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 16:03:16 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9S53FKa011795
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 16:03:15 +1100
Message-ID: <4EAA378D.2080304@in.ibm.com>
Date: Fri, 28 Oct 2011 10:33:09 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com> <4E943C70.4030106@in.ibm.com>
 <1318428902.3782.9.camel@nimitz> <4EA6D701.3030603@freescale.com>
 <4EA85B95.9030802@in.ibm.com> <4EA85C85.7090404@freescale.com>
 <4EA919AE.4020508@in.ibm.com> <4EA97BB1.8020009@freescale.com>
In-Reply-To: <4EA97BB1.8020009@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/11 21:11, Scott Wood wrote:
> On 10/27/2011 03:43 AM, Suzuki Poulose wrote:
>> On 10/27/11 00:46, Scott Wood wrote:
>>> On 10/26/2011 02:12 PM, Suzuki Poulose wrote:
>>>> I have renamed the new type of relocation to RELOCATABLE_PPC32_PIE. The
>>>> patches
>>>> were posted yesterday. Please let me know your thoughts.
>>>
>>> I think it would make more sense to rename the existing behavior (maybe
>>> something like DYNAMIC_MEMSTART -- if there's even enough overhead to
>>> make it worth being configurable at all), since it's not fully
>>> relocatable and since 64-bit already uses RELOCATABLE to mean PIE.
>>
>> I think leaving the current behaviour as it is, and adding the PIE as an
>> additional configuration option would be safe and wouldn't disturb the
>> existing dependencies.
>
> That's how things grow to be an unmaintainable mess.  AFAICT, what
> you're doing is the same as what 64-bit does for RELOCATABLE.  If
> they're doing the same thing, they should be called the same thing.
> Whereas 64-bit and e500 are currently doing different things for
> RELOCATABLE -- so they should be called different things.

OK. Agreed. I will resend the patches with the change.

Thanks
Suzuki
