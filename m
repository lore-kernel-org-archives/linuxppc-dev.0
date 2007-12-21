Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 62D2EDDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:17:58 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so264475wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 13:17:57 -0800 (PST)
Message-ID: <fa686aa40712211317o401be150n32196a25b5ab1481@mail.gmail.com>
Date: Fri, 21 Dec 2007 14:17:57 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
In-Reply-To: <20071221210445.GA5190@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071221202824.GA4607@localhost.localdomain>
	<fa686aa40712211250l2645d34dr45c5be2bf1c9006d@mail.gmail.com>
	<20071221210445.GA5190@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/21/07, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> As I've probably said once already: if there are plans to build single
> kernel with QE+CPM1+CPM2 inside tomorrow -- then of course, I'd better
> wait.
>
> But if these plans are distant enough, I see no reason why we can't
> enjoy of current API.

Oh, I'm not saying don't enjoy it.  :-)  I'm just saying keep it out
of mainline.  I've got a bunch of Virtex stuff that falls into that
category.  Those who are interested can pick the non mainlined patches
out of my git tree.

I suggest doing the same with the GPIO support.  Either that or do our
own simple ppc specific GPIO multiplexer until the common stuff has
its act together.  :-)  We can always migrate over later.

I don't want to see more barriers added to prevent all of 8xxx going
multiplatform.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
