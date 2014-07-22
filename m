Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9DE81A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 17:00:28 +1000 (EST)
Message-ID: <1406012425.28595.0.camel@concordia>
Subject: Re: [PATCH] powerpc: Revert removing of _INIT_GLOBAL(), _STATIC()
 and _INIT_STATIC()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 Jul 2014 17:00:25 +1000
In-Reply-To: <1406009637.22200.14.camel@pasglop>
References: <20140714201204.7b6fcd8e@gandalf.local.home>
 <1405389955.9343.48.camel@pasglop>
 <20140721145651.465db070@gandalf.local.home>
 <1406009637.22200.14.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-22 at 16:13 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2014-07-21 at 14:56 -0400, Steven Rostedt wrote:
> > > Weird ... what are your gcc and binutils versions ? Smells like a
> > > toolchain issue to me but I need to dig a bit more. Doesn't hit any
> > > of my test configs here.
> > > 
> > 
> > Can you test the attached config with this toolchain and see if you get
> > the same build bug.
> 
> Yeah ok, I hit it too, it's one of those issues with the bloody
> alternate feature sections getting pushed too far away. Argh.

This should fix it temporarily at least:

  http://patchwork.ozlabs.org/patch/369950/

cheers
