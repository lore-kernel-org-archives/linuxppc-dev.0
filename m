Return-Path: <michel@daenzer.net>
Received: from smtp103.rog.mail.re2.yahoo.com (smtp103.rog.mail.re2.yahoo.com
	[206.190.36.81]) by ozlabs.org (Postfix) with SMTP id 2DB382BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 09:27:24 +1100 (EST)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Armando Di Cianno <fafhrd@gentoo.org>
In-Reply-To: <e40ed3e4cb162b693ee83310e34b9a3d@nephiliah>
References: <e40ed3e4cb162b693ee83310e34b9a3d@nephiliah>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Nov 2004 17:20:47 -0500
Message-Id: <1100989247.4668.39.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: Michel Daenzer <michel@daenzer.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-11-20 at 17:08 -0500, Armando Di Cianno wrote:
> On 2004-11-20 16:47:34 -0500 Sean Neakums <sneakums@zork.net> wrote:
> > I tried this on my 15" AlBook (one of the new 1.5GHz ones), applied to
> > Debian's 2.6.9.  It suspended and resumed fine (and quickly!), but
> > after resume I noticed that images (in Mozilla and the root window)
> > would become corrupted if obscured and made visible again, e.g. by
> > switching tabs, or by moving between a full and an empty workspace.
>=20
> Just a note that I tried this with gentoo's=20
> gentoo-dev-sources-2.6.9-r3 and discovered the exact some symptoms. =20
> It mainly only seems to have corrupted the X root window, although=20
> some, but not all, images in a web page in firefox show similar=20
> distortions.  Currently my system is running XOrg 6.7.0.  I did not=20
> notice this problem with the first patch for sleep.

Sounds like the offscreen pixmap cache gets corrupted. The usual
question for this kind of problem: Does

grep APM /var/log/X{Free86,org}.0.log

show

(II) Open APM successful

?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
