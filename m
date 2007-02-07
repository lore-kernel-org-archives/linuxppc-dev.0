Return-Path: <akpm@linux-foundation.org>
Date: Wed, 7 Feb 2007 14:21:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] spufs: remove need for struct page for SPEs
Message-Id: <20070207142112.e7856c3f.akpm@linux-foundation.org>
In-Reply-To: <20070207045055.295F3DDE46@ozlabs.org>
References: <1170823850.450936.293648942401.qpush@grosgo>
	<20070207045055.295F3DDE46@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Feb 2007 15:50:52 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch removes the need for struct page for SPE local store
> and registers from spufs. It also makes the locking much more
> obvious and no longer relying on the truncate logic black magic
> for protecting against races between unmap_mapping_range() and
> new pages faulted in. It does so by switching to a nopfn() handler
> and using the new vm_insert_pfn() to setup the PTEs itself while
> holding a lock on the SPE.

Some of this patch seems to already be in Paul's tree.  Or something.
I'll duck this patch.
