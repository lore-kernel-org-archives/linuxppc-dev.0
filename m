Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlPbz4nN0zDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 23:22:23 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qlPbz1RgDz9t5w
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2016 23:22:22 +1000 (AEST)
Date: Wed, 13 Apr 2016 15:22:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
In-Reply-To: <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
Message-ID: <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
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

On Wed, 13 Apr 2016, Miroslav Benes wrote:

> > This series adds live patching support for powerpc (ppc64le only ATM).
> > 
> > It's unchanged since the version I posted on March 24, with the exception that
> > I've dropped the first patch, which was a testing-only patch.
> > 
> > If there's no further comments I'll put this in a topic branch in the next day
> > or two and Jiri & I will both merge that into next.
> 
> Hi,
> 
> I'll definitely give it a proper look today or tomorrow, but there is one 
> thing that needs to be solved. The patch set from Jessica reworking 
> relocations for live patching is now merged in our for-next branch. This 
> means that we need to find out if there is something in struct 
> mod_arch_specific for powerpc which needs to be preserved and do it.

Michael, if the plan is still the original one, i.e. you push it to your 
branch, and I merge it to livepatching (and resolve any dependencies on 
the relocations code during the merge) and push it to Linus from 
livepatching.git, then there shouldn't be anything do to on your side.

Alternatively, you can rebase on top of livepatching.git#for-next, and 
I'll take it directly.

Thanks,

-- 
Jiri Kosina
SUSE Labs
