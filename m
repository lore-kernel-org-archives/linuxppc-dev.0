Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id D810D67A5C
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 07:08:35 +1000 (EST)
Date: Fri, 2 Jun 2006 14:08:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
	vma close
In-Reply-To: <1149281841.9693.39.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
	<1149281841.9693.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2 Jun 2006, Adam Litke wrote:

> The real reason I want to "close" hugetlb regions (even on 64bit
> platforms) is so a process can replace a previous hugetlb mapping with
> normal pages when huge pages become scarce.  An example would be the
> hugetlb morecore (malloc) feature in libhugetlbfs :)

Well that approach wont work on IA64 it seems.
