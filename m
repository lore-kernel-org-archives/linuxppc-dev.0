Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 4CE87B70FC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 05:20:27 +1000 (EST)
Date: Fri, 1 Oct 2010 14:20:25 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/9] v3 Allow memory blocks to span multiple memory
	sections
Message-ID: <20101001192025.GQ14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62917.80008@austin.ibm.com>
	<4CA62FE2.2000003@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA62FE2.2000003@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 01, 2010 at 02:00:50PM -0500, Nathan Fontenot wrote:
> Update the memory sysfs code such that each sysfs memory directory is now
> considered a memory block that can span multiple memory sections per
> memory block.  The default size of each memory block is SECTION_SIZE_BITS
> to maintain the current behavior of having a single memory section per
> memory block (i.e. one sysfs directory per memory section).
> 
> For architectures that want to have memory blocks span multiple
> memory sections they need only define their own memory_block_size_bytes()
> routine.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Reviewed-by: Robin Holt <holt@sgi.com>
