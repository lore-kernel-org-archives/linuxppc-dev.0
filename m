Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPPzl0DXVzDvWt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 14:37:55 +1100 (AEDT)
Date: Thu, 24 Nov 2016 14:37:49 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, benh@kernel.crashing.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/2] Preliminary cleanups for HPT resizing
Message-ID: <20161124033749.376ugjrnvnwbhmut@oak.ozlabs.ibm.com>
References: <1479878047-19431-1-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479878047-19431-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2016 at 04:14:05PM +1100, David Gibson wrote:
> Hi Paul,
> 
> I'm still chasing this confusion about the CAS bit to send the real
> HPT resizing patches.  However, in the meantime, here are some
> preliminary cleanups.
> 
> These cleanups stand on their own, although I wrote them in the
> context of writing the HPT resizing code, and are prerequisites for
> those patches.
> 
> David Gibson (2):
>   kvm: Move KVM_PPC_PVINFO_FLAGS_EV_IDLE definition next to its
>     structure
>   powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
> 
>  arch/powerpc/kvm/powerpc.c | 5 ++++-
>  include/uapi/linux/kvm.h   | 5 +++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

Thanks, series applied to my kvm-ppc-next branch.

Paul.
