Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 774ECDDEE1
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 23:15:17 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fedora Core 6 or 7 on PPC?
Date: Mon, 19 Mar 2007 13:15:09 +0100
References: <20070319120442.8F5A035260B@atlas.denx.de>
In-Reply-To: <20070319120442.8F5A035260B@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703191315.10004.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 19 March 2007, Wolfgang Denk wrote:
> in message <200703190134.26030.arnd@arndb.de> you wrote:
> >
> > I don't have an up-to-date version of it right here, but in case you
> > are trying to do an installation of the minimal rpm files from a
> > running system, I can recommend the following procedure:
> >=20
> > rpm --root /fc7/ --initdb
> > rpm --root /fc7/ -ivh --nodeps ftp://ftp-stud.fht-esslingen.de/Mirrors/=
fedora.redhat.com/linux/core/development/ppc/os/Fedora/fedora-release-*.noa=
rch.rpm
> > yum --installroot=3D/fc7/ -y groupinstall Base
>=20
> Thanks a lot - that was exactly what I was looking for without knowing
> that it exitsts.
>=20
> Where did you get this =A0information =A0from? =A0The =A0man =A0page =A0d=
oes =A0not
> explain any of the group* actions ?

I googled for fedora and debootstrap when I last needed this.

	Arnd <><
