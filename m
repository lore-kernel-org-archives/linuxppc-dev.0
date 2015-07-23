Return-Path: <ralf@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id B92A21A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 17:10:05 +1000 (AEST)
Received: from localhost.localdomain ([127.0.0.1]:34915 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S27009831AbbGWG7Bi5k7I (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Thu, 23 Jul 2015 08:59:01 +0200
Date: Thu, 23 Jul 2015 08:58:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-am33-list@redhat.com,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Vlastimil Babka <vbabka@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
 linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150723065830.GA5919@linux-mips.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
 <20150722141501.GA3203@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722141501.GA3203@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:

> > 
> > You haven't wired it up properly on powerpc, but I haven't mentioned it because
> > I'd rather we did it.
> > 
> > cheers
> 
> It looks like I will be spinning a V5, so I will drop all but the x86
> system calls additions in that version.

The MIPS bits are looking good however, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

With my ack, will you keep them or maybe carry them as a separate patch?

Cheers,

  Ralf
