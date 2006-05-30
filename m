Return-Path: <michel@daenzer.net>
Received: from darkcity.gna.ch (darkcity.gna.ch [195.226.6.42])
	by ozlabs.org (Postfix) with ESMTP id A913B679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 18:17:59 +1000 (EST)
Subject: Re: [Done] Re: snd-aoa: Sound gone after snd-aoa updates, on PB5,8
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060529221730.GA3138@localhost>
References: <20060529020027.GA3107@localhost> <20060529021756.GB3107@localhost>
	<1148869725.3918.12.camel@localhost.localdomain>
	<20060529221730.GA3138@localhost>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 May 2006 09:44:32 +0200
Message-Id: <1148975072.27856.294.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-30 at 00:17 +0200, Wolfgang Pfeiffer wrote:
>=20
> The problem is: with libasound2 1.0.11-6 I cannot even *start*=20
> alsamixer:
>=20
> ------------------------
> $ alsamixer
> ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL default
>=20
> alsamixer: function snd_ctl_open failed for default: No such file or dire=
ctory

See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D369478 and friends.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphics.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
