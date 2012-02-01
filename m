Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C796EB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 21:48:46 +1100 (EST)
Message-ID: <1328093320.28487.75.camel@pasglop>
Subject: Re: next BUG: using smp_processor_id() in preemptible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Wed, 01 Feb 2012 21:48:40 +1100
In-Reply-To: <alpine.LSU.2.00.1201312208270.1859@eggly.anvils>
References: <alpine.LSU.2.00.1112051539100.3938@sister.anvils>
 <alpine.LSU.2.00.1112220405410.23876@eggly.anvils>
 <1324588672.6632.8.camel@pasglop>
 <alpine.LSU.2.00.1201141419530.1266@eggly.anvils>
 <1326603920.26116.18.camel@pasglop>
 <alpine.LSU.2.00.1201312208270.1859@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-31 at 22:12 -0800, Hugh Dickins wrote:
> > Grrr, my memory is a colander... And now am in Ballarat for the week
> > with a semi working 3g connection. I'll see what I can do.
> 
> Sorry to be such a bore - you can guess what I have to say about
> 3.3-rc2 :()

Yeah, I'm looking at reworking the whole thing, I think we have another
deeper problem with lazy interrupt disable and implicit re-enable from
an exception exit too... stay tuned.

Cheers,
Ben.
