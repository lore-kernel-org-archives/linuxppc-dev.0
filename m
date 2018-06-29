Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H0994TWBzF1Q2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 11:55:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v2 0/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
In-Reply-To: <20180626055926.27703-1-aik@ozlabs.ru>
References: <20180626055926.27703-1-aik@ozlabs.ru>
Date: Fri, 29 Jun 2018 11:55:40 +1000
Message-ID: <877emiwe3n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> This is to improve page boundaries checking and should probably
> be cc:stable. I came accross this while debugging nvlink2 passthrough
> but the lack of checking might be exploited by the existing userspace.

Do you really mean "exploited" ? As in there's a security issue?

Your change log for patch 2 sort of suggests that but then says that
without the fix you just hit an error in vfio code.

So I'm not clear on what the exposure is.

cheers
