Return-Path: <davidsen@tmr.com>
Received: from gaimboi.tmr.com (mail.tmr.com [64.65.253.246])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90977DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 04:35:15 +1000 (EST)
Message-ID: <48B31245.4040505@tmr.com>
Date: Mon, 25 Aug 2008 16:12:53 -0400
From: Bill Davidsen <davidsen@tmr.com>
MIME-Version: 1.0
To: Paul Collins <paul@burly.ondioline.org>
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
References: <20080802184554.GB715@fieldses.org>	<87abfvm4cc.fsf@burly.wgtn.ondioline.org>	<877iayy4qc.fsf@burly.wgtn.ondioline.org>	<18581.40960.737792.454035@notabene.brown>	<87r696l1yo.fsf@burly.wgtn.ondioline.org>	<18582.32935.501672.689845@notabene.brown>	<87fxpll5zq.fsf@burly.wgtn.ondioline.org>	<87y73dcd60.fsf@burly.wgtn.ondioline.org>	<1217860597.12535.2.camel@localhost>	<87hca05ws4.fsf@burly.wgtn.ondioline.org>	<20080804205908.GA29890@fieldses.org>	<1217895418.7951.7.camel@localhost>	<8763qg5don.fsf@burly.wgtn.ondioline.org>	<1217910862.7951.22.camel@localhost>
	<871w145ar3.fsf@burly.wgtn.ondioline.org>
In-Reply-To: <871w145ar3.fsf@burly.wgtn.ondioline.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Collins wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:

>> Also, how old is the machine? Any chance you're just seeing random
>> memory corruption?
> 
> It's about four years old.  It was in storage for about six months and I
> got it repaired a few weeks ago (display cable and inverter).  The sort
> of crazy crap I've been reporting certainly smacks of memory corruption.
> But on the other hand, 2.6.25 (Debian's) and 2.6.26 (my own) have been
> trouble-free.
> 
While it is possible that the new kernel tickles a hardware bug and all 
the old ones don't, I would put my $ on the kernel being the issue.

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
