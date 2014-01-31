Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91A102C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 21:39:05 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 16:08:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 295A8E0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:11:54 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VAcXPP30605376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:08:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VAcdd2028106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:08:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 01/10] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR
 emulation
In-Reply-To: <52E92D15.8000901@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92D15.8000901@suse.de>
Date: Fri, 31 Jan 2014 16:08:39 +0530
Message-ID: <87y51wjv0w.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
>> We definitely don't need to emulate mtspr, because both the registers
>> are hypervisor resource.
>
> This patch description doesn't cover what the patch actually does. It 
> changes the implementation from "always tell the guest it uses 100%" to 
> "give the guest an accurate amount of cpu time spent inside guest
> context".

Will fix that

>
> Also, I think we either go with full hyp semantics which means we also 
> emulate the offset or we go with no hyp awareness in the guest at all 
> which means we also don't emulate SPURR which is a hyp privileged
> register.

Can you clarify this ?

>
> Otherwise I like the patch :).
>

-aneesh
