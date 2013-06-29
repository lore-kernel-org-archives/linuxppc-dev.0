Return-Path: <paulus@ozlabs.org>
Date: Sat, 29 Jun 2013 17:14:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 1/4] mm/cma: Move dma contiguous changes into a
 seperate config
Message-ID: <20130629071432.GB8687@iris.ozlabs.ibm.com>
References: <1372410662-3748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372410662-3748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, mina86@mina86.com,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 28, 2013 at 02:40:59PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We want to use CMA for allocating hash page table and real mode area for
> PPC64. Hence move DMA contiguous related changes into a seperate config
> so that ppc64 can enable CMA without requiring DMA contiguous.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>

When you send out the next version, please cc kvm-ppc@vger.kernel.org,
kvm@vger.kernel.org and Alexander Graf <agraf@suse.de>.

Paul.
