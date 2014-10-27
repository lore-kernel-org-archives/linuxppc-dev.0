Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A883F1A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 10:06:13 +1100 (AEDT)
Date: Mon, 27 Oct 2014 16:06:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Message-Id: <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
In-Reply-To: <1414233860-7683-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1414233860-7683-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 Steve Capper <steve.capper@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 25 Oct 2014 16:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Update generic gup implementation with powerpc specific details.
> On powerpc at pmd level we can have hugepte, normal pmd pointer
> or a pointer to the hugepage directory.

I grabbed these.  It would be better if they were merged into the powerpc
tree where they'll get more testing than in linux-next alone.
