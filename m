Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id CC95F1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 02:52:22 +1100 (AEDT)
Date: Fri, 12 Feb 2016 15:52:22 +0000
From: Will Deacon <will.deacon@arm.com>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
Message-ID: <20160212155221.GP25087@arm.com>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad> <20160212100137.GE25087@arm.com>
 <alpine.LFD.2.20.1602121106140.1773@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.20.1602121106140.1773@schleppi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 12, 2016 at 11:12:34AM +0100, Sebastian Ott wrote:
> On Fri, 12 Feb 2016, Will Deacon wrote:
> > On Thu, Feb 11, 2016 at 08:57:02PM +0100, Gerald Schaefer wrote:
> > > On Thu, 11 Feb 2016 21:09:42 +0200
> > > "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> > > > On Thu, Feb 11, 2016 at 07:22:23PM +0100, Gerald Schaefer wrote:
> > > > > Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
> > > > > he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
> > > > > review of the THP rework patches, which cannot be bisected, revealed
> > > > > commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
> > > > > (and also similar commits for other archs).

[...]

> > Do you have a reliable way to trigger the "random kernel crashes"? We've not
> > seen anything reported on arm64, but I don't see why we wouldn't be affected
> > by the same bug and it would be good to confirm and validate a fix.
> 
> My testcase was compiling the kernel. Most of the time my test system
> didn't survive a single compile run. During bisect I did at least 20
> compile runs to flag a commit as good.

I've been building kernels all day with -rc3 on my arm64 box and haven't
seen any problems yet.. :/.

I'll leave it going over the weekend.

Will
