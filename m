Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBA9EB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 01:39:48 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Mar 2012 20:09:42 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2FEddIa4460602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 20:09:40 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2FKAESJ000753
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 07:10:15 +1100
Message-ID: <4F61FF26.6030205@in.ibm.com>
Date: Thu, 15 Mar 2012 20:09:34 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 0/2] Kdump support for PPC_47x
References: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
 <20120315061128.GA3320@thor.bakeyournoodle.com>
In-Reply-To: <20120315061128.GA3320@thor.bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/15/2012 11:41 AM, Tony Breeds wrote:
> On Wed, Mar 14, 2012 at 03:52:30PM +0530, Suzuki K. Poulose wrote:
>> The following series implements Kexec/Kdump support for
>> PPC_47x based platforms. Doesn't support SMP yet.
>>
>> I have tested these patches on simics simulator for ppc476.
>
> I'll test these patches on the currituck board I have here early next
> week.

Thanks a lot Tony !

Suzuki
