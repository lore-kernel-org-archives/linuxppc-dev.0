Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gCZL52wczF1nd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 18:38:50 +1000 (AEST)
Date: Tue, 8 May 2018 10:38:32 +0200
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace for
 newer consistency models
Message-ID: <20180508103832.085378b9@blackhole.lan>
In-Reply-To: <20180507154208.jo4s43olrf5a3hw4@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble>
 <20180504123834.GA16581@lst.de>
 <20180507154208.jo4s43olrf5a3hw4@treble>
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

On Mon, 7 May 2018 10:42:08 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> The subject doesn't actively describe what the patch does, maybe
> change it to something like:
> 
>   powerpc: Add support for HAVE_RELIABLE_STACKTRACE
> 
> or maybe
> 
>   powerpc: Add support for livepatch consistency model

Maybe $SUBJECT? You're absolutely right, the old subject was just a
leftover of my original attempt to just set the flag, before Miroslav
corrected me. I just kept on copying it without a second thought. Thanks
for noting.

> Otherwise it looks great to me.
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
Thanks.

	Torsten
