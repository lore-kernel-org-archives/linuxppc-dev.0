Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F19C67C11
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 22:10:21 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 03/12] snd-aoa: add aoa core
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hk67s4ywh.wl%tiwai@suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130911.997152000@sipsolutions.net>
	<s5hk67s4ywh.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Oef2AFpX+8sFpfuLlfcJ"
Date: Fri, 09 Jun 2006 14:10:02 +0200
Message-Id: <1149855002.3864.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Oef2AFpX+8sFpfuLlfcJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:13 +0200, Takashi Iwai wrote:
> At Wed, 07 Jun 2006 15:09:12 +0200,
> Johannes Berg wrote:
> >=20
> > --- /dev/null
> > +++ b/sound/aoa/core/snd-aoa-gpio-pmf.c
> (snip)
> > +void pmf_handle_notify_irq(void *data)
> > +{
>=20
> Missing static.

Added, thanks.

> > --- /dev/null
> > +++ b/sound/aoa/core/snd-aoa-gpio-feature.c
> (snip)
> > +static struct device_node *get_gpio(
> > +	char *name, char *altname, int *gpioptr, int *gpioactiveptr)
>=20
> Unconventional style.

Heh ok, fixed.

> > +irqreturn_t ftr_handle_notify_irq(int xx, void *data, struct pt_regs *=
regs)
> > +{
>=20
> Missing static.

Added.

> > +static int ftr_set_notify(struct gpio_runtime *rt,
> > +			  enum notify_type type,
> > +			  notify_func_t notify,
> > +			  void *data)
> (snip)
> > +	if (old && !notify) {
> > +		free_irq(irq, notif);
> > +	}
> > +	if (!old && notify) {
> > +		request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
> > +	}
>=20
> Remove braces. =20

Right.

> Any error check from request_irq()?

Ah, I figured it didn't matter, but it indeed does. Fixed.

johannes

--=-Oef2AFpX+8sFpfuLlfcJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIllGKVg1VMiehFYAQLieg/7BrQJUfyNhRwabyy6A5GQuV5i8W6V5Mxk
FboPzPp52VfuteqUcCtpItoztKmCsLwJrZA9s4YyLAiYFjNUzN31mSejPatK3ZuE
2Rka2x3dEbvinYHP8LvIo6YdlbeLwX10zCIe1aJOvf+7lwb8z1xGus/GXDaqK9ht
UsmN2mX+HCpxs5RbLHeem+85moquMCacNF+qnOUGwMc6QoQBtQOGy0N3tZ3t6XE3
Dt5iqoyNwMNqxBtPkx1q0kfiKV4+LIJWFN8pFHEwojObYyicFtyayTQ2IFzehVe7
TnKMmxHhfJVdhfJT3xdFkX7nkzNCGV/kCE6RUR5qtcPCoUxacUKji1UdU5JZNjME
OuWXe1wtbO2DzFOZ3WzcwKQdZP7729OkqQqzhEsNyVIW96wwyiU0mOK25OPdGrY9
SSfO05kGgVL6GHU3bq3clFQufOj30G2DPUthdyml79aGameITQ0htKkqcCF2RGH7
AnG8623YP5ChTv47lfZzD4dTF7bEFS2P8reWytPewPV2+dsCTYDFlGln2uSvs5mm
ox15PSpSQLKlX2KtBasNnQNquSRC3q36upxDZKcjf5IGsirX0/sKtxO3Mt59nuEh
erTNKsurzlQKNWRzSlQgdjMQzcX9XOqZbblRCoOYLLddwV4DYEGo/0a/MVYJkt0A
GGRweIstSGI=
=FG4v
-----END PGP SIGNATURE-----

--=-Oef2AFpX+8sFpfuLlfcJ--
