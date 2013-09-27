Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3C4E2C0377
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:45:50 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 22:45:42 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 45ED23578050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:45:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RCjS4Q9437550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:45:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RCjc9p004459
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:45:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 04/11] kvm: powerpc: book3s: Add a new config variable
 CONFIG_KVM_BOOK3S_HV
In-Reply-To: <F47EA67A-B8C0-409F-A4D4-3BA7D11E01F5@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <F47EA67A-B8C0-409F-A4D4-3BA7D11E01F5@suse.de>
Date: Fri, 27 Sep 2013 18:15:33 +0530
Message-ID: <8761tmbfgy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This help ups to select the relevant code in the kernel code
>> when we later move HV and PR bits as seperate modules.
>
> I don't think I grasp what semantically the difference between
> CONFIG_KVM_BOOK3S_HV and CONFIG_KVM_BOOK3S_64_HV is :).

When we later enable kvm-hv CONFIG_KVM_BOOK3S_64_HV becomes 'm' So we
can't do #ifdef CONFIG_KVM_BOOK3S_64_HV

-aneesh
