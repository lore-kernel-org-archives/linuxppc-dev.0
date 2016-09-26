Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjVlM1znFzDrR8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:07:43 +1000 (AEST)
Date: Mon, 26 Sep 2016 09:59:54 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160926165954.GD5871@two.firstfloor.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
 <20160920002820.GE11991@kernel.org> <20160922150022.GA20134@krava>
 <20160922162713.GA31617@krava> <20160926083533.GA15523@krava>
 <20160926150343.GJ5588@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160926150343.GJ5588@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 26, 2016 at 12:03:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 26, 2016 at 10:35:33AM +0200, Jiri Olsa escreveu:
> > ping.. is that working for you? IMO we can include this
> > as additional patch to the set..
> 
> No, it doesn't fails to build on the first cross env I tried, fixing it
> now, resulting patch:

Yes it shouldn't be difficult to fix cross building. I don't think
there are any fundamental problems.

-Andi
