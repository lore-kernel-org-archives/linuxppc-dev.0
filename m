Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 1282CB7CEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 23:23:39 +1100 (EST)
Subject: Re: Booting headless PowerMac G5
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <8028e5751003260320i37fee6a9l74379c3279850c9e@mail.gmail.com>
References: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
	<1269509341.441.2779.camel@thor.local>
	<8028e5751003260320i37fee6a9l74379c3279850c9e@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Mar 2010 13:23:32 +0100
Message-ID: <1269606212.4274.14.camel@thor.local>
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

On Fri, 2010-03-26 at 11:20 +0100, Romain Goyet wrote:=20
> 2010/3/25 Michel D=C3=A4nzer <michel@daenzer.net>:
> > On Wed, 2010-03-24 at 11:32 +0100, Romain Goyet wrote:
> >>
> >> By the way, as of writing this, grub2 on PPC from debian gives a "out
> >> of memory" issue. Known bug.
> >
> > That's on the G5? It's working on my PowerBook, but I haven't updated
> > the grub2 binaries on the bootstrap partition in a while...
>=20
> Yeah, that's on a PowerMac QuadG5.
> I think that's a known issue :
> http://www.mail-archive.com/grub-devel@gnu.org/msg04455.html
> However it might be another one since it's working for you. I'm using
> grub2 from Debian stable.

According to http://packages.debian.org/stable/grub2 that's version 1.96
+20080724-16, which is pretty old. Current in sid is 1.98, and it's only
become usable for me in the course of the last year or so.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
