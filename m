Return-Path: <mcree@orcon.net.nz>
Received: from nctlincom01.orcon.net.nz (nctlincom01.orcon.net.nz
 [60.234.4.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BB042C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 14:57:48 +1100 (EST)
Received: from mx3.orcon.net.nz (mx3.orcon.net.nz [219.88.242.53])
 by nctlincom01.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id
 r0P3oXsQ005919
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 16:50:33 +1300
Received: from Debian-exim by mx3.orcon.net.nz with local (Exim 4.69)
 (envelope-from <mcree@orcon.net.nz>) id 1TyaJE-0008GX-I3
 for linuxppc-dev@lists.ozlabs.org; Fri, 25 Jan 2013 16:50:32 +1300
Message-Id: <43E02291-8F84-40CD-B429-847E7533EA18@orcon.net.nz>
From: Michael Cree <mcree@orcon.net.nz>
To: Michel Lespinasse <walken@google.com>
In-Reply-To: <1357694895-520-3-git-send-email-walken@google.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/8] mm: use vm_unmapped_area() on alpha architecture
Date: Fri, 25 Jan 2013 16:49:58 +1300
References: <1357694895-520-1-git-send-email-walken@google.com>
 <1357694895-520-3-git-send-email-walken@google.com>
Cc: Rik van Riel <riel@redhat.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/01/2013, at 2:28 PM, Michel Lespinasse wrote:
> Update the alpha arch_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

'Tis running fine on my alpha.

Tested-by: Michael Cree <mcree@orcon.net.nz>

Cheers
Michael.
