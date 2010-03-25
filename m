Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id D95BDB7C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 20:37:37 +1100 (EST)
Subject: Re: Booting headless PowerMac G5
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
References: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Mar 2010 10:29:01 +0100
Message-ID: <1269509341.441.2779.camel@thor.local>
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

On Wed, 2010-03-24 at 11:32 +0100, Romain Goyet wrote:=20
>=20
>   Here's a summary about "how to boot a PowerMac G5 without a screen
> attached". As many people have noticed, default yaboot install won't
> boot unless a screen is attached.
>=20
>   Actually, the workaround is really simple. Thing is, that's the
> "ofboot.b" script that messes things up. This script is a "bridge",
> that actually either starts yaboot or let you boot off of a CD. I
> don't know what's the point, since OpenFirmware already lets you boot
> off of the CD by pressing C on boot=E2=80=A6
>=20
>   So basically, to boot headless, all you have to do is to tell
> OpenFirmware to boot straight off the yaboot binary, and to skip the
> ofboot.b
> Just boot into OpenFirmware (Command-Option-O-F), and type :
> setenv boot-device hd:2,yaboot (where 2 is the number of the partition
> containing yaboot)
> boot
>=20
> And here you go, you can unplug that useless monitor :-)
>=20
> References :
> http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOOT=
.html
> http://grub.enbug.org/TestingOnPowerPC

That's good to know, thanks.


> By the way, as of writing this, grub2 on PPC from debian gives a "out
> of memory" issue. Known bug.

That's on the G5? It's working on my PowerBook, but I haven't updated
the grub2 binaries on the bootstrap partition in a while...


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
