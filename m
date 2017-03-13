Return-Path: <kirill@shutemov.name>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhbFB0nTSzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:27:24 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id l37so19598271wrc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:27:24 -0700 (PDT)
Date: Mon, 13 Mar 2017 14:27:20 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Anton Blanchard <anton@samba.org>
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com,
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 5-level pagetable patches break ppc64le
Message-ID: <20170313112720.7swcwp7rkrtr7fqo@node.shutemov.name>
References: <20170313210550.173a7950@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313210550.173a7950@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 13, 2017 at 09:05:50PM +1100, Anton Blanchard wrote:
> Hi,
> 
> My ppc64le boot tests stopped working as of commit c2febafc6773 ("mm:
> convert generic code to 5-level paging")
> 
> We hang part way during boot, just before bringing up the network. I
> haven't had a chance to narrow it down yet.

Please check if patch by this link helps:

http://lkml.kernel.org/r/20170313052213.11411-1-kirill.shutemov@linux.intel.com

-- 
 Kirill A. Shutemov
