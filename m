Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2E3F1A0727
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:11:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 15:11:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 72AAF357804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:11:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R5BDvc49414344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:11:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R5AlTR024014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:10:47 +1000
Date: Mon, 27 Apr 2015 10:39:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCHv2 2/8] perf probe: Improve detection of file/function
 name in the probe pattern
Message-ID: <20150427050952.GD6113@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202414.GD3550@kernel.org> <5502C7EF.8080007@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5502C7EF.8080007@hitachi.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/03/13 08:20PM, Masami Hiramatsu wrote:
> (2015/03/13 5:24), Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 15, 2014 at 08:20:32PM +0530, Naveen N. Rao escreveu:
> >> Currently, perf probe considers patterns including a '.' to be a file.
> >> However, this causes problems on powerpc ABIv1 where all functions have
> >> a leading '.':
> >>
> >>   $ perf probe -F | grep schedule_timeout_interruptible
> >>   .schedule_timeout_interruptible
> >>   $ perf probe .schedule_timeout_interruptible
> >>   Semantic error :File always requires line number or lazy pattern.
> >>     Error: Command Parse Error.
> >>
> >> Fix this by checking the probe pattern in more detail.
> > 
> > Masami, can I have your Acked-by or Reviewed-by?
> 
> As far as I can see, this is not enough for fixing that issue.
> Could you fold the first half of [4/8] to this patch?
> I also have some comments on it. See below.

Masami, Arnaldo,
Thanks for the review. v3 patches forthcoming...

- Naveen
