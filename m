Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DB5342C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 08:24:28 +1100 (EST)
Message-ID: <50EDE009.9030001@redhat.com>
Date: Wed, 09 Jan 2013 16:24:25 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 7/8] mm: use vm_unmapped_area() on powerpc architecture
References: <1357694895-520-1-git-send-email-walken@google.com>
 <1357694895-520-8-git-send-email-walken@google.com>
In-Reply-To: <1357694895-520-8-git-send-email-walken@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2013 08:28 PM, Michel Lespinasse wrote:
> Update the powerpc slice_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Acked-by: Rik van Riel <riel@redhat.com>
