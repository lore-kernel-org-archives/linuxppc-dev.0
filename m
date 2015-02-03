Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED7C81A0C8D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 18:46:53 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Tue, 3 Feb 2015 07:46:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 816421B08061
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 07:46:52 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t137kjvC10682638
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 07:46:45 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t137kjmD023735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 02:46:45 -0500
Date: Tue, 3 Feb 2015 08:46:40 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 0/4] VPHN parsing fixes
Message-ID: <20150203084640.70b60a7c@bahia.local>
In-Reply-To: <1422931655.4625.6.camel@ellerman.id.au>
References: <20141217094007.16957.70423.stgit@bahia.local>
 <20150129190353.401248ab@bahia.local>
 <1422931655.4625.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Feb 2015 13:47:35 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Thu, 2015-01-29 at 19:03 +0100, Greg Kurz wrote:
> > On Wed, 17 Dec 2014 10:40:46 +0100
> > Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> > > Hi,
> > > 
> > > This series addresses remarks from Ben and Michael (see individual patches).
> > > The most notable changes are:
> > > - the parsing code being pull out into a separate file in patch 3/4. This
> > >   allows to write userland tests like the one below.
> > > - a full rewrite of the parsing logic in patch 4/4
> > > 
> > 
> > Ping ?
> 
> Sorry, lots of patches needing review.
> 

Heh, no problem. :) Since this isn't bugfix, I can even repost later, when
the review pressure is lower.

> This looks pretty good at a glance, but did you actually write a userspace test
> for it? If so please send it. I'm happy to rework it into something that can go
> in selftests.
> 

Yes, I wrote the premise of a test program. You can find it in the cover mail of
this series:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123601.html

I'll have a look at selftests.

> cheers
> 
> 

Thanks.

--
Greg
