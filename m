Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F39361A0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 00:17:30 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88D1D140322
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 00:17:30 +1100 (AEDT)
Date: Thu, 25 Feb 2016 14:17:27 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 02/12] powerpc/module: Mark module stubs with a magic value
Message-ID: <20160225131727.GD21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456324115-21144-2-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 01:28:25AM +1100, Michael Ellerman wrote:
> 
> We can make that process easier by marking the generated stubs with a
> magic value, and then looking for that magic value. Altough this is not
> as rigorous as the current method, I believe it is sufficient in
> practice.

The actual magic value is sort of debatable; it should be "improbable"
enough. But this can be changed easily, for each kernel compile, even.

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Torsten Duwe <duwe@suse.de>

[for reference:]
>  
> +#define STUB_MAGIC 0x73747562 /* stub */
> +

	Torsten
