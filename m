Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]  PPC32 : Huge-page support for ppc440
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1162864834.3809.21.camel@zod.rchland.ibm.com>
References: <454FC362.9070608@linux.vnet.ibm.com>
	<1162864834.3809.21.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 13:24:47 +1100
Message-Id: <1162866287.28571.392.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Edi Shmueli <edi@linux.vnet.ibm.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 20:00 -0600, Josh Boyer wrote:
> Hi Edi,
> 
> On Mon, 2006-11-06 at 18:21 -0500, Edi Shmueli wrote:
> > From: Edi Shmueli edi@linux.vnet.ibm.com
> > 
> > This patch enables applications to exploit the PPC440 TLB support for 
> > huge-page mapping, to minimize TLB thrashing.
> > Applications with large memory footprint that exploit this support, 
> > experience minimal TLB misses, and boost in performance.
> > NAS benchmarks performed with this patch indicate hundreds of percent of 
> > improvement in performance for some application.
> > Known limitations: because each PMD covers 2MB of the process address 
> > space, the minimal huge-page size supported by this patch is 2M.
> > 
> > Signed-off-by: Edi Shmueli edi@linux.vnet.ibm.com
> 
> Your patch is line wrapped and the whitespace has been corrupted.  It's
> also against a bit older version of the kernel.
> 
> Could you try to fixup these issues and resubmit?  Paul's powerpc.git
> tree would probably be best to diff against.

Also, while it's great to have somebody do this work, I doubt there is
much interest in merging it for arch/ppc... 

Ben.
