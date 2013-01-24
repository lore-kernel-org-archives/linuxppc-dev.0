Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 28DFE2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 01:13:35 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1358990991-21316-4-git-send-email-walken@google.com>
References: <1358990991-21316-4-git-send-email-walken@google.com>
 <1358990991-21316-1-git-send-email-walken@google.com>
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 3/8] mm: use vm_unmapped_area() on frv architecture
Date: Thu, 24 Jan 2013 14:13:10 +0000
Message-ID: <27625.1359036790@warthog.procyon.org.uk>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michel Lespinasse <walken@google.com> wrote:

> Update the frv arch_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Acked-by: Rik van Riel <riel@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>
