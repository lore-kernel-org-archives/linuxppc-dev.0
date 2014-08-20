Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 2DA781A015C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:59:59 +1000 (EST)
Date: Wed, 20 Aug 2014 11:44:58 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2] PC, KVM, CMA: Fix regression caused by wrong
 get_order() use
Message-ID: <20140820024458.GA2415@js1304-P5Q-DELUXE>
References: <1407992587-9164-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407992587-9164-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2014 at 03:03:07PM +1000, Alexey Kardashevskiy wrote:
> fc95ca7284bc54953165cba76c3228bd2cdb9591 claims that there is no
> functional change but this is not true as it calls get_order() (which
> takes bytes) where it should have called ilog2() and the kernel stops
> on VM_BUG_ON().
> 
> This replaces get_order() with order_base_2() (round-up version of ilog2).
> 
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Sorry for my fault. :(

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
