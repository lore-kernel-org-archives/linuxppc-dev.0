Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 307881A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 21:15:14 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Marc Dietrich <marvin24@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Geoff Levand <geoff@infradead.org>
Subject: Re: Time to remove platforms/cell?
Date: Thu, 17 Sep 2015 13:15:06 +0200
Message-ID: <6872814.PfbzHq6PSL@wuerfel>
In-Reply-To: <2785247.ZjG8XMQlJP@fb07-iapwap2>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <1442483138.26748.4.camel@ellerman.id.au> <2785247.ZjG8XMQlJP@fb07-iapwap2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 17 September 2015 12:28:13 Marc Dietrich wrote:
> Am Donnerstag, 17. September 2015, 19:45:38 schrieb Michael Ellerman:
> > On Thu, 2015-09-17 at 10:43 +0200, Marc Dietrich wrote:
> > > Am Donnerstag, 17. September 2015, 15:28:47 schrieb Michael Ellerman:
> >
> > [...]
> >
> > Having said all that, this email was mainly a fishing expedition to see if
> > anyone still cares about Cell support at all. It sounds like you at least
> > are running mainline kernels on PS3?
> 
> well, I like to but I couldn't get the kernel booting for some reason. Still 
> trying. Beside this, I have nothing against dropping the other cell systems, 
> but I'm only a "fun user", so my vote probably isn't counting 

No, your vote counts at least as much as a commercial user, because
"fun users" are more likely to contribute back patches when something
breaks.

	Arnd
