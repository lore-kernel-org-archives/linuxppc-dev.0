Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5038567A01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 05:04:07 +1000 (EST)
Date: Mon, 24 Apr 2006 23:04:13 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: 85xx FDT updates?
Message-ID: <20060424230413.5344770b@vitb.ru.mvista.com>
In-Reply-To: <1145900516.4251.18.camel@cashmere.sps.mot.com>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Apr 2006 12:41:56 -0500
Jon Loeliger <jdl@freescale.com> wrote:

> OK, so what is the deal with the 85xx patches
> that have been submitted for more FDT support?
> I get a variety of mixed stories, message and
> vague comments.  I want some facts and direction.
> 
> Can anyone verify, validate, refute, deny or
> support any of these statements?  Not trying to
> be mean, point fingers or sound negative here,
> I'm just trying to pinpoint the apparent log-jam.
> 
> 
> 1. The 85xx patches that Andy submitted, that
>    have been pulled into Kumar's 85xx git tree
>    are going to sit there until further patches
>    are submitted that _remove_all_85xx_support_
>    from the arch/ppc tree as well.
> 
> 2. The same patches are going to sit in Kumar's
>    tree until 8560 patches with support for CPM
>    are released and all 85xx ports appear fully
>    and completely in arch/powerpc.  BTW, CPM is
>    waiting on approval of Vitaly's CPM proposal
>    for OF FDT support.
> 
> 3. Statements 1 and 2 combined.
> 

That's my understanding. We agreed to have the CPM dts that is limited to "devices" only,
(scc, fcc or ucc) inside it. 

Right now I am in process of update the drivers part (yet keeping compatibility with existing ppc stuff, that is tricky), then I am going to rework immap stuff a bit to utilize the parts that are common across the PQ family, and go ahead with some CPM(2) code to powerpc.

> 4. The same 85xx patches have just slipped through
>    some mental crack and simply need to be pulled,
>    re-applied, re-drafted, re-submitted.  Oops, sorry.
>    The action item is in _________'s lap.
> 
> 5. There was an unresolved comment/issue that
>    FSL still needs to address.  BTW, that issue
>    is ________.
> 
> 6. We are waiting on something else and that
>    item is _______.
> 
Well, as already mentioned, the CPM2-related drivers the way they are could not be utilized in powerpc 
sane way. Thankfully, the update is 90% ready right now.

> 7. You know, you really need to address the _other_
>    85xx ports (such as TQMs) as well.  Can you
>    please do something about those as well?
> 
> 8. These Linux patches aren't going to be picked
>    up until the corresponding U-Boot patches are
>    picked up as well.
> 
> Thanks,
> jdl
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 


-- 
Sincerely, 
Vitaly
