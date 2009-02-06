Return-Path: <michel@daenzer.net>
Received: from smtp-wifi.orange.fr (smtp-wifi-out.orange.fr [80.12.242.163])
	by ozlabs.org (Postfix) with ESMTP id 931BEDDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 05:07:36 +1100 (EST)
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090205205809.GA10793@zod.rchland.ibm.com>
References: <1233806493.4612.65.camel@pasglop>
	<20090205134700.GB3000@yoda.jdub.homelinux.org>
	<1233867382.4612.98.camel@pasglop>
	<20090205205809.GA10793@zod.rchland.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 06 Feb 2009 18:42:36 +0100
Message-Id: <1233942156.5081.454.camel@thor.local>
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

On Thu, 2009-02-05 at 15:58 -0500, Josh Boyer wrote:
> On Fri, Feb 06, 2009 at 07:56:22AM +1100, Benjamin Herrenschmidt wrote:
> >
> >> Which begs the question of what master is for.  So far, it's just been
> >> a mirror of next from what I can tell.  Maybe it should just track
> >> Linus' tree?
> >
> >I've been wondering myself what to do with it ... I may just leave it to
> >track linus indeed. Or maybe just delete it.
>=20
> I don't think you can delete it without hosing people who try to clone it=
.

The branch to check out by git clone can be overridden via a special
file in the .git directory in the shared repository. Unfortunately
though, I don't remember what it's called...


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
