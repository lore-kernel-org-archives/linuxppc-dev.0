Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhYRR1K6QzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 21:06:10 +1100 (AEDT)
Date: Mon, 13 Mar 2017 21:05:50 +1100
From: Anton Blanchard <anton@samba.org>
To: kirill.shutemov@linux.intel.com, mhocko@suse.com,
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: 5-level pagetable patches break ppc64le
Message-ID: <20170313210550.173a7950@kryten>
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

Hi,

My ppc64le boot tests stopped working as of commit c2febafc6773 ("mm:
convert generic code to 5-level paging")

We hang part way during boot, just before bringing up the network. I
haven't had a chance to narrow it down yet.

Anton
