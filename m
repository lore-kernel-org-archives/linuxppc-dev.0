Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AA261A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 12:20:30 +1100 (AEDT)
Message-ID: <1414459229.31711.0.camel@concordia>
Subject: Re: [PATCH V3 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 28 Oct 2014 12:20:29 +1100
In-Reply-To: <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
References: <1414233860-7683-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 Steve Capper <steve.capper@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-27 at 16:06 -0700, Andrew Morton wrote:
> On Sat, 25 Oct 2014 16:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > Update generic gup implementation with powerpc specific details.
> > On powerpc at pmd level we can have hugepte, normal pmd pointer
> > or a pointer to the hugepage directory.
> 
> I grabbed these.  It would be better if they were merged into the powerpc
> tree where they'll get more testing than in linux-next alone.
 
Fine by me. Can I get an ack from you and/or someone else on CC?

cheers
