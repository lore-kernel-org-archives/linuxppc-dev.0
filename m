Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgDTm62MZzDwCB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 02:18:20 +1100 (AEDT)
Date: Fri, 16 Dec 2016 09:18:15 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/livepatch: Remove klp_write_module_reloc() stub
Message-ID: <20161216151815.tltq6x3ghdchc2o4@treble>
References: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 16, 2016 at 11:44:24AM +0530, Kamalesh Babulal wrote:
> commit 425595a7fc20 ("livepatch: reuse module loader code
> to write relocations") offloads livepatch module relocation
> write to arch specific module loader code.
> 
> Remove unused klp_write_module_reloc() function stub.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
