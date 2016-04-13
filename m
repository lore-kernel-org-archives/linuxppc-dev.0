Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlP7g65XLzDqym
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 23:01:19 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qlP7g2Y8Pz9t6S
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2016 23:01:19 +1000 (AEST)
Date: Wed, 13 Apr 2016 15:01:15 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
In-Reply-To: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2016, Michael Ellerman wrote:

> This series adds live patching support for powerpc (ppc64le only ATM).
> 
> It's unchanged since the version I posted on March 24, with the exception that
> I've dropped the first patch, which was a testing-only patch.
> 
> If there's no further comments I'll put this in a topic branch in the next day
> or two and Jiri & I will both merge that into next.

Hi,

I'll definitely give it a proper look today or tomorrow, but there is one 
thing that needs to be solved. The patch set from Jessica reworking 
relocations for live patching is now merged in our for-next branch. This 
means that we need to find out if there is something in struct 
mod_arch_specific for powerpc which needs to be preserved and do it.

Regards,
Miroslav
