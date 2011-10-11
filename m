Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F211FB6F64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 23:54:19 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
 by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9BCsCtA004352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 23:54:12 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9BCsCKd2490622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 23:54:12 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9BCsBgU031558
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 23:54:12 +1100
Message-ID: <4E943C70.4030106@in.ibm.com>
Date: Tue, 11 Oct 2011 18:24:08 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com>
In-Reply-To: <4E9332AA.1050307@freescale.com>
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

On 10/10/11 23:30, Scott Wood wrote:
> On 10/10/2011 04:56 AM, Suzuki K. Poulose wrote:
>> #if defined(CONFIG_RELOCATABLE)&&  defined(CONFIG_44x)
>> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
>> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
>> #endif
>
> Why is this 44x-specific?

As of now, we compile with relocations only for the 44x. We could make this
generic once the approach is accepted by everyone and implemented on the other
platforms.

Thanks

Suzuki
