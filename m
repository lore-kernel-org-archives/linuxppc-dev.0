Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 128BEDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 14:25:50 +1000 (EST)
Date: Wed, 14 May 2008 06:25:44 +0200
From: Nick Piggin <npiggin@suse.de>
To: kniht@linux.vnet.ibm.com
Subject: Re: [PATCH 0/6] 16G and multi size hugetlb page support on powerpc
Message-ID: <20080514042544.GA23578@wotan.suse.de>
References: <4829CAC3.30900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4829CAC3.30900@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>,
	Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 13, 2008 at 12:07:15PM -0500, Jon Tollefson wrote:
> This patch set builds on Nick Piggin's patches for multi size and giant 
> hugetlb page support of April 22.  The following set of patches adds 
> support for 16G huge pages on ppc64 and support for multiple huge page 
> sizes at the same time on ppc64.  Thus allowing 64K, 16M, and 16G huge 
> pages given a POWER5+ or later machine.
> 
> New to this version of my patch is numerous bug fixes and cleanups, but 
> the biggest change is the support for multiple huge page sizes on power.
> 
> patch 1: changes to generic hugetlb to enable 16G pages on power
> patch 2: powerpc: adds function for allocating 16G pages
> patch 3: powerpc: setups 16G page locations found in device tree
> patch 4: powerpc: page definition support for 16G pages
> patch 5: check for overflow when user space is 32bit
> patch 6: powerpc: multiple huge page size support

Hi Jon,

Thanks very much. I'll put these at the end of my patchset and attempt
to keep them building if I make changes to the core code (have to spend
a bit of time catching up with the review comments from last round).

I'll send out another patchset for review in a day or so after I catch
up, and then hopefully get it merged in -mm for 2.6.27.

Thanks,
Nick
