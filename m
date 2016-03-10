Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99E9E1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 19:46:25 +1100 (AEDT)
Date: Thu, 10 Mar 2016 19:46:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] powerpc/powernv/iommu: Add real mode version
 of xchg()
Message-ID: <20160310084621.GD1230@fergus.ozlabs.ibm.com>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2016 at 02:41:12PM +1100, Alexey Kardashevskiy wrote:
> In real mode, TCE tables are invalidated using different
> cache-inhibited store instructions which is different from
> the virtual mode.

I suggest "In real mode, TCE tables are invalidated using special
cache-inhibited store instructions which are not available in
virtual mode".

Also, the subject could make people think it's about the kernel xchg()
function defined in <asm/cmpxchg.h>.

Paul.
