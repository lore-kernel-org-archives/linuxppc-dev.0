Return-Path: <takashi.iwai@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id 6183767AC6
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 02:50:14 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id y7so1275335rne
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Apr 2005 09:50:13 -0700 (PDT)
Message-ID: <6dc076840504240943598b05f2@mail.gmail.com>
Date: Sun, 24 Apr 2005 18:43:32 +0200
From: Takashi Iwai <takashi.iwai@gmail.com>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050424182456.34e92bd2@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050421200408.5361a5b3@jack.colino.net>
	<1114129034.18680.34.camel@gaston>
	<20050424182456.34e92bd2@jack.colino.net>
Cc: Takashi Iwai <tiwai@suse.de>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc3] pmac: save master volume on sleep
Reply-To: Takashi Iwai <takashi.iwai@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Colin,

the patch looks OK to me too.
Could you resend this to Jaroslav to apply it to ALSA tree, since I'm
in vacation...?

Thanks.


Takashi

On 4/24/05, Colin Leroy <colin@colino.net> wrote:
> On 22 Apr 2005 at 10h04, Benjamin Herrenschmidt wrote:
>=20
> Hi,
>=20
> > > Hi,
> > >
> > > Ben's patch that shutdowns master switch and restores it after
> > > resume ("pmac: Improve sleep code of tumbler driver") isn't enough
> > > here on an iBook (snapper chip).
> > >
> > > The master switch is correctly saved and restored, but somehow
> > > tumbler_put_master_volume() gets called just after
> > > tumbler_set_master_volume() and sets mix->master_vol[*] to 0. So, on
> > > resuming, the master switch is reenabled, but the volume is set to
> > > 0.
> > >
> > > Here's a patch that also saves and restores master_vol.
> > > Thanks,
> >
> > Looks good.
>=20
> Takashi: any news or comments on this?
>=20
> Thanks,
> --
> Colin
>=20
>
