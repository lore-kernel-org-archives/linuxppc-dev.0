Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by lists.ozlabs.org (Postfix) with ESMTP id 49F891A084E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 19:21:28 +1000 (EST)
Message-ID: <538D9363.7020203@redhat.com>
Date: Tue, 03 Jun 2014 11:20:35 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Michal Nazarewicz <mina86@mina86.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 3/3] PPC, KVM, CMA: use general CMA reserved area
 management framework
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-4-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1ttx82jx1i.fsf@mina86.com>
In-Reply-To: <xa1ttx82jx1i.fsf@mina86.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 03/06/2014 09:02, Michal Nazarewicz ha scritto:
> On Tue, Jun 03 2014, Joonsoo Kim wrote:
>> Now, we have general CMA reserved area management framework,
>> so use it for future maintainabilty. There is no functional change.
>>
>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Aneesh, can you test this series?

Paolo
