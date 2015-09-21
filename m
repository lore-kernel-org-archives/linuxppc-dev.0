Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9B61A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:42:43 +1000 (AEST)
Message-ID: <1442828562.12401.1.camel@ellerman.id.au>
Subject: Re: Time to remove platforms/cell?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Marc Dietrich <marvin24@gmx.de>, Geoff
 Levand <geoff@infradead.org>
Date: Mon, 21 Sep 2015 19:42:42 +1000
In-Reply-To: <6872814.PfbzHq6PSL@wuerfel>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <1442483138.26748.4.camel@ellerman.id.au> <2785247.ZjG8XMQlJP@fb07-iapwap2>
 <6872814.PfbzHq6PSL@wuerfel>
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

On Thu, 2015-09-17 at 13:15 +0200, Arnd Bergmann wrote:
> On Thursday 17 September 2015 12:28:13 Marc Dietrich wrote:
> > Am Donnerstag, 17. September 2015, 19:45:38 schrieb Michael Ellerman:
> > > On Thu, 2015-09-17 at 10:43 +0200, Marc Dietrich wrote:
> > > > Am Donnerstag, 17. September 2015, 15:28:47 schrieb Michael Ellerman:
> > >
> > > [...]
> > >
> > > Having said all that, this email was mainly a fishing expedition to see if
> > > anyone still cares about Cell support at all. It sounds like you at least
> > > are running mainline kernels on PS3?
> > 
> > well, I like to but I couldn't get the kernel booting for some reason. Still 
> > trying. Beside this, I have nothing against dropping the other cell systems, 
> > but I'm only a "fun user", so my vote probably isn't counting 
> 
> No, your vote counts at least as much as a commercial user, because
> "fun users" are more likely to contribute back patches when something
> breaks.

Yep. I'm quite happy for us to try and maintain support indefinitely if folks
are still using the systems, and especially if they're able to report the odd
breakage that happens.

cheers
