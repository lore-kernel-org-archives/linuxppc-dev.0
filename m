Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3mQP4F6czDr5N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 17:27:09 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u36so3081898pgn.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 00:27:09 -0700 (PDT)
Message-ID: <1499412358.23251.7.camel@gmail.com>
Subject: Re: [RFC v5 01/38] powerpc: Free up four 64K PTE bits in 4K backed
 HPTE pages
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org,  x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org,  corbet@lwn.net, mingo@redhat.com
Date: Fri, 07 Jul 2017 17:25:58 +1000
In-Reply-To: <1499289735-14220-2-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-2-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-05 at 14:21 -0700, Ram Pai wrote:
> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6,
> in the 4K backed HPTE pages.These bits continue to be used
> for 64K backed HPTE pages in this patch, but will be freed
> up in the next patch. The  bit  numbers are big-endian  as
> defined in the ISA3.0
> 
> The patch does the following change to the 4k htpe backed
> 64K PTE's format.
>

The diagrams make the patch much easier to understand, thanks!

<snip>
 
> NOTE:even though bits 3, 4, 5, 6, 7 are  not  used  when
> the  64K  PTE is backed by 4k HPTE,  they continue to be
> used  if  the  PTE  gets  backed  by 64k HPTE.  The next
> patch will decouple that aswell, and truely  release the
> bits.
>

<snip>

Balbir Singh. 
