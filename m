Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id E046067A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 19:23:31 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Date: Thu, 3 Mar 2005 09:23:22 +0100
References: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
	<200503011737.22205.g.jaeger@sysgo.com>
	<20050302215308.GA6511@wohnheim.fh-wedel.de>
In-Reply-To: <20050302215308.GA6511@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503030923.22677.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 02 March 2005 22:53, J=F6rn Engel wrote:
> On Tue, 1 March 2005 17:37:22 +0100, Gerhard Jaeger wrote:
> > On Tuesday 01 March 2005 17:14, Zeighami, Roy wrote:
> > >=20
> > > When I select 44x as the CPU type, I don't see "Bamboo" under machine
> > > type. =20
> >=20
> > This won't work, as Bamboo BSP stuff is currently not added.
>=20
> Correct.
>=20
> > > Any suggestions?
> >=20
> > try to use ebony_defconfig
>=20
> Doesn't work, neither does ocotea.  Both are able to display "TUX!" on
> the dot-matrix display, but panic before writing any serial output.
>=20
> /me has one of these beauties as well and will try to hack up support
> for it.  If anyone has patches or suggestions, help is always
> appreciated.
>=20
Could not confirm that so far! Ebony and Ocotea are working out of the
box, using these defconfig files! (pristine kernel 2.6.11)

Gerhard

=2D-=20
Gerhard Jaeger <gjaeger@sysgo.com>           =20
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de=20
