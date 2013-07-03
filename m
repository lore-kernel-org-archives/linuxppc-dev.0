Return-Path: <paulus@ozlabs.org>
Date: Wed, 3 Jul 2013 16:16:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 4/4] powerpc/kvm: Use 256K chunk to track both RMA
 and hash page table allocation.
Message-ID: <20130703061626.GB25034@drongo>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372743918-12293-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, Jul 02, 2013 at 11:15:18AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Both RMA and hash page table request will be a multiple of 256K. We can use
> a chunk size of 256K to track the free/used 256K chunk in the bitmap. This
> should help to reduce the bitmap size.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>

Thanks!
