Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 22F8DDDDA2
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Feb 2009 22:56:23 +1100 (EST)
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1233942156.5081.454.camel@thor.local>
References: <1233806493.4612.65.camel@pasglop>
	<20090205134700.GB3000@yoda.jdub.homelinux.org>
	<1233867382.4612.98.camel@pasglop>
	<20090205205809.GA10793@zod.rchland.ibm.com>
	<1233942156.5081.454.camel@thor.local>
Content-Type: text/plain; charset=utf-8
Date: Sun, 08 Feb 2009 12:56:09 +0100
Message-Id: <1234094169.5081.540.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-02-06 at 18:42 +0100, Michel D=C3=A4nzer wrote:
> On Thu, 2009-02-05 at 15:58 -0500, Josh Boyer wrote:
> > On Fri, Feb 06, 2009 at 07:56:22AM +1100, Benjamin Herrenschmidt wrote:
> > >
> > >> Which begs the question of what master is for.  So far, it's just be=
en
> > >> a mirror of next from what I can tell.  Maybe it should just track
> > >> Linus' tree?
> > >
> > >I've been wondering myself what to do with it ... I may just leave it =
to
> > >track linus indeed. Or maybe just delete it.
> >=20
> > I don't think you can delete it without hosing people who try to clone =
it.
>=20
> The branch to check out by git clone can be overridden via a special
> file in the .git directory in the shared repository. Unfortunately
> though, I don't remember what it's called...

According to Julien Cristau of the Debian X Strike Force (none of the
Git repos of which have a master branch), it should be .git/HEAD. Some
experiments of mine seem to confirm this.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
