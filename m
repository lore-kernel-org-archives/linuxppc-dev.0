Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Feb 2013 14:37:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: aik@ozlabs.ru
Subject: Re: [PATCH 3/4] powerpc: preparing to support real mode optimization
Message-ID: <20130215033740.GC25015@drongo>
References: <1360584763-21988-1-git-send-email-a>
 <5118e069.22ca320a.1f08.ffffe2f0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5118e069.22ca320a.1f08.ffffe2f0@mx.google.com>
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 11:12:42PM +1100, aik@ozlabs.ru wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> he current VFIO-on-POWER implementation supports only user mode
> driven mapping, i.e. QEMU is sending requests to map/unmap pages.
> However this approach is really slow in really fast hardware so
> it is better to be moved to the real mode.
> 
> The patch adds an API to increment/decrement page counter as
> get_user_pages API used for user mode mapping does not work
> in the real mode.
> 
> CONFIG_SPARSEMEM_VMEMMAP and CONFIG_FLATMEN are supported.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---

The names are slightly odd, in that they include "vmemmap_" but exist
and work in the flatmem case as well.  Apart from that...

Reviewed-by: Paul Mackerras <paulus@samba.org>

Paul.
