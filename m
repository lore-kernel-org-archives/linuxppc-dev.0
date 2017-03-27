Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs2765BRkzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 16:06:26 +1100 (AEDT)
Date: Mon, 27 Mar 2017 16:06:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH kernel v11 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
Message-ID: <20170327050621.GA28680@fergus.ozlabs.ibm.com>
References: <20170322042156.11756-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322042156.11756-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2017 at 03:21:46PM +1100, Alexey Kardashevskiy wrote:
> This is my current queue of patches to add acceleration of TCE
> updates in KVM.
> 
> This is based on sha1 093b995e3b55 Huang Ying "mm, swap: Remove WARN_ON_ONCE() in free_swap_slot()".
> 
> Please comment. Thanks.

Looks like this is about ready to go in.  Since it has acks from Alex
Williamson for the relatively small changes to vfio code, the relevant
maintainers are Michael Ellerman and Paolo Bonzini.  Michael has
proposed doing a topic branch with the first 4 patches that I will
pull into my kvm-ppc-next branch, apply the remaining 6 patches and
then request Paolo to pull.  Paolo, are you OK with that plan and with
the changes to KVM uapi files in patches 5 and 10?

Paul.
