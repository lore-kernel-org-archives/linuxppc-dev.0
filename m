Return-Path: <michel@daenzer.net>
Received: from mail1.ati.com (mail1.ati.com [209.50.91.165])
	by ozlabs.org (Postfix) with ESMTP id 032E62BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 08:20:44 +1100 (EST)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Keith Conger <keith.conger@gmail.com>
In-Reply-To: <4517b8e04112208383cc9b24c@mail.gmail.com>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
	<6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Nov 2004 16:13:36 -0500
Message-Id: <1101158016.1623.18.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: Michel Daenzer <michel@daenzer.net>
Cc: gentoo-ppc-user@gentoo.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-11-22 at 11:38 -0500, Keith Conger wrote:
>=20
> Works great here also (15" 1GHz PB). One issue which may be unrelated
> I have some sound issues. For instance one a sound is played it sounds
> fine but if a sound is played right after its volume is extremely low.
> But with headphones this doesn't occur.

Make sure that DRC is disabled or that it's set up to operate on a
reasonable (i.e. non-empty :) range.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
