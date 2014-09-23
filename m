Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5B8F1A009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 19:43:44 +1000 (EST)
Message-ID: <1411465423.28213.2.camel@concordia>
Subject: Re: [PATCH v2] PowerPC: boot: Parse chosen/cmdline-timeout parameter
From: Michael Ellerman <mpe@ellerman.id.au>
To: Simon =?ISO-8859-1?Q?K=E5gstr=F6m?= <simon.kagstrom@netinsight.net>
Date: Tue, 23 Sep 2014 19:43:43 +1000
In-Reply-To: <20140923105616.0dd666ff@marrow.netinsight.se>
References: <20140909164006.0e3593f0@marrow.netinsight.se>
 <20140923105616.0dd666ff@marrow.netinsight.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: grant.likely@linaro.org, geert@linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-23 at 10:56 +0200, Simon Kågström wrote:
> Hi again!
> 
> On Tue, 9 Sep 2014 16:40:06 +0200
> Simon Kågström <simon.kagstrom@netinsight.net> wrote:
> 
> > A 5 second timeout during boot might be too long, so make it
> > configurable. Run the loop at least once to let the user stop the boot
> > by holding a key pressed.
> 
> Sorry to bother the list, but it would be nice if this patch could
> trickle down into some tree if it's seen as acceptable. So consider
> this a ping :-)

Yeah looks sane to me.

Personally I've never used that feature, I guess I don't have many (any?)
machines with real serial which seems to be a requirement for it to work.

I'll put it in my next tomorrow unless Scott or anyone else objects.

cheers
