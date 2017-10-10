Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yBNt13v6gzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:10:48 +1100 (AEDT)
Date: Tue, 10 Oct 2017 18:10:47 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Michal Hocko <mhocko@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
Message-ID: <20171010171047.GC2517@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pavel,

On Tue, Oct 10, 2017 at 01:07:35PM -0400, Pavel Tatashin wrote:
> Thank you for doing this work. How would you like to proceed?
> 
> - If you OK for my series to be accepted as-is, so your patch can be
> added later on top, I think, I need an ack from you for kasan changes.
> - Otherwise, I can replace: 4267aaf1d279 arm64/kasan: add and use
> kasan_map_populate() in my series with code from your patch.

I was thinking that you could just add my patch to the end of your series
and have the whole lot go up like that. If you want to merge it with your
patch, I'm fine with that too.

Will
