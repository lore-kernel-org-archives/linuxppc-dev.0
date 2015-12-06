Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9318E1A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 10:58:24 +1100 (AEDT)
Message-ID: <1449446304.23526.2.camel@ellerman.id.au>
Subject: Re: more POLL... fun
From: Michael Ellerman <mpe@ellerman.id.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 07 Dec 2015 10:58:24 +1100
In-Reply-To: <20151204173031.GJ22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <3199712.spOmaGJUoN@wuerfel> <20151204152133.GI22011@ZenIV.linux.org.uk>
 <2220761.5EzR0eY4bg@wuerfel> <20151204173031.GJ22011@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-04 at 17:30 +0000, Al Viro wrote:
> On Fri, Dec 04, 2015 at 06:13:54PM +0100, Arnd Bergmann wrote:
> > Yes, I think that would be best. Do you want me to send that patch, or do
> > you prefer to do it yourself? In theory that patch should also go into stable
> > kernels, but I suspect nobody who still owns a machine that is able to run
> > this code will ever upgrade to a stable release, so we probably don't need
> > that.
> 
> Probably better if it goes through ppc tree - the only relationship it has
> to VFS is broken calls of kill_fasync() in now-removed code...  Something
> like this, perhaps?

Yeah that looks fine to me. I'll take it into powerpc#next for 4.5.

cheers
