Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TNHd0BFzzF361
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 09:37:16 +1000 (AEST)
Date: Mon, 16 Jul 2018 09:37:12 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel v3 3/6] KVM: PPC: Make iommu_table::it_userspace
 big endian
Message-ID: <20180715233712.GA6727@fergus>
References: <20180704061349.20742-1-aik@ozlabs.ru>
 <20180704061349.20742-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704061349.20742-4-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2018 at 04:13:46PM +1000, Alexey Kardashevskiy wrote:
> We are going to reuse multilevel TCE code for the userspace copy of
> the TCE table and since it is big endian, let's make the copy big endian
> too.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
