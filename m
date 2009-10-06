Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id BEC85B7C0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 23:53:58 +1100 (EST)
Subject: Re: SMU-base PowerMac and server_mode
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <8028e5750910060444jd63dffcl6f57bb15c708e4c6@mail.gmail.com>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254826247.4278.985.camel@thor.local>
	<8028e5750910060444jd63dffcl6f57bb15c708e4c6@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 14:53:53 +0200
Message-Id: <1254833633.4278.1495.camel@thor.local>
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

On Tue, 2009-10-06 at 13:44 +0200, Romain Goyet wrote:=20
>=20
> Acutally I didn't figure it out by myself :
> http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOOT=
.html
>=20
>=20
> However, here's my 2 cents about it :
> 1/ The fix (removing "screen" line in ofboot.b on yaboot partition)
> doesn't work with all versions of the yaboot binary. Works with the
> one from Debian. Doesn't with yaboot-static on GentooPPC64. But you
> still can fetch the right binary from the .deb archive

No need, see my .sig. :) Thanks for the pointer, I failed to find the
above when I googled about this a while ago.=20

--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
