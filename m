Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJkGn3XsDzDvk8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 23:34:37 +1100 (AEDT)
Subject: Re: [PATCH 1/1] sched: provide common cpu_relax_yield definition
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org,
 virtualization@lists.linux-foundation.org
From: David Hildenbrand <david@redhat.com>
Message-ID: <c41d574c-c89e-e518-91bb-3acd701e5023@redhat.com>
Date: Wed, 16 Nov 2016 13:34:22 +0100
MIME-Version: 1.0
In-Reply-To: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 16.11.2016 um 13:23 schrieb Christian Borntraeger:
> No need to duplicate the same define everywhere. Since
> the only user is stop-machine and the only provider is
> s390, we can use a default implementation of cpu_relax_yield
> in sched.h.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Looks good to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

David
