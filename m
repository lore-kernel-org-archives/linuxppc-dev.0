Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] spufs: remove need for struct page
	for SPEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <1170890152.2620.313.camel@localhost.localdomain>
References: <1170823850.450936.293648942401.qpush@grosgo>
	<20070207045055.295F3DDE46@ozlabs.org>
	<20070207142112.e7856c3f.akpm@linux-foundation.org>
	<1170890152.2620.313.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 14:59:48 +1100
Message-Id: <1170993588.2620.407.camel@localhost.localdomain>
Mime-Version: 1.0
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


> Only the 3rd patch in the serie is "new". Duck it for now, I posted it
> mostly for review/comments, if it goes it, it will go through Paulus
> though I will need Nick's vm_insert_pfn and and my NOPFN_REFAULT in
> first and that's where you get involved :-)

BTW, Patch has a bug, it doesn't set VM_PFNMAP in all mmap calls, fixing
that now.

Ben.
 
