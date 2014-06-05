Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B03A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 03:00:12 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 22:30:08 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 42BB33940049
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:30:05 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55H0oS257802762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:30:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55H03Z3025421
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:30:04 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Michal Nazarewicz <mina86@mina86.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 3/3] PPC, KVM,
 CMA: use general CMA reserved area management framework
In-Reply-To: <538D9363.7020203@redhat.com>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-4-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1ttx82jx1i.fsf@mina86.com> <538D9363.7020203@redhat.com>
Date: Thu, 05 Jun 2014 22:30:02 +0530
Message-ID: <8761kfuwa5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 03/06/2014 09:02, Michal Nazarewicz ha scritto:
>> On Tue, Jun 03 2014, Joonsoo Kim wrote:
>>> Now, we have general CMA reserved area management framework,
>>> so use it for future maintainabilty. There is no functional change.
>>>
>>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>
>> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>>
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Aneesh, can you test this series?

Sorry for the late reply. I will test this and update here.

-aneesh
