Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhqYN5rtNzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:42:16 +1100 (AEDT)
Date: Tue, 14 Mar 2017 07:41:42 +1100
From: Anton Blanchard <anton@samba.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com,
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: 5-level pagetable patches break ppc64le
Message-ID: <20170314074142.6b13c0a8@kryten>
In-Reply-To: <20170313112720.7swcwp7rkrtr7fqo@node.shutemov.name>
References: <20170313210550.173a7950@kryten>
 <20170313112720.7swcwp7rkrtr7fqo@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kirill,

> > My ppc64le boot tests stopped working as of commit c2febafc6773
> > ("mm: convert generic code to 5-level paging")
> > 
> > We hang part way during boot, just before bringing up the network. I
> > haven't had a chance to narrow it down yet.  
> 
> Please check if patch by this link helps:
> 
> http://lkml.kernel.org/r/20170313052213.11411-1-kirill.shutemov@linux.intel.com

It does fix the ppc64le boot hangs, thanks.

Tested-by: Anton Blanchard <anton@samba.org>

Anton
