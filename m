Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9F461A0156
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 07:12:17 +1100 (AEDT)
Message-ID: <1417551115.27448.7.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 07:11:55 +1100
In-Reply-To: <87k32ah5q3.fsf@linux.vnet.ibm.com>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473762.7182.8.camel@kernel.crashing.org>
 <87k32ah5q3.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-02 at 12:57 +0530, Aneesh Kumar K.V wrote:
> Now, hash_preload can possibly insert an hpte in hash page table even if
> the access is not allowed by the pte permissions. But i guess even that
> is ok. because we will fault again, end-up calling hash_page_mm where we
> handle that part correctly.

I think we need a test case...

Cheers,
Ben.
