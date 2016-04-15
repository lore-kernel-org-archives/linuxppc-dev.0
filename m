Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmgqv5bm8zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2016 01:07:07 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qmgqv20qQz9t6T
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Apr 2016 01:07:06 +1000 (AEST)
Date: Fri, 15 Apr 2016 17:07:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Miroslav Benes <mbenes@suse.cz>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
In-Reply-To: <1460616590.2754.6.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1604151136320.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au>
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

On Thu, 14 Apr 2016, Michael Ellerman wrote:

> Topic branch here:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/livepatch
> 
> I will merge that before Monday (my time) if I don't hear any objections.

I've now pulled this into livepatching.git#for-4.7/livepatching-ppc64 and 
merged that branch into for-next as well.

That branch already contains all the relocation changes queued for 4.7, so 
as much testing of the merged result as possible on ppc64 would be 
appreciated.

Thanks everybody,

-- 
Jiri Kosina
SUSE Labs
