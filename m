Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg5zY2wbszDw9m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 21:25:12 +1100 (AEDT)
Date: Fri, 16 Dec 2016 11:25:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jessica Yu <jeyu@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/livepatch: Remove klp_write_module_reloc() stub
Message-ID: <20161216102506.GA393@pathway.suse.cz>
References: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2016-12-16 11:44:24, Kamalesh Babulal wrote:
> commit 425595a7fc20 ("livepatch: reuse module loader code
> to write relocations") offloads livepatch module relocation
> write to arch specific module loader code.
> 
> Remove unused klp_write_module_reloc() function stub.

Yup, the function is not longer used.

> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
