Return-Path: <paulus@ozlabs.org>
Date: Wed, 3 Jul 2013 16:15:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 2/4] powerpc/kvm: Contiguous memory allocator based
 hash page table allocation
Message-ID: <20130703061531.GA25034@drongo>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, agraf@suse.de, mina86@mina86.com, linux-mm@kvack.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 02, 2013 at 11:15:16AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Powerpc architecture uses a hash based page table mechanism for mapping virtual
> addresses to physical address. The architecture require this hash page table to
> be physically contiguous. With KVM on Powerpc currently we use early reservation
> mechanism for allocating guest hash page table. This implies that we need to
> reserve a big memory region to ensure we can create large number of guest
> simultaneously with KVM on Power. Another disadvantage is that the reserved memory
> is not available to rest of the subsystems and and that implies we limit the total
> available memory in the host.
> 
> This patch series switch the guest hash page table allocation to use
> contiguous memory allocator.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
