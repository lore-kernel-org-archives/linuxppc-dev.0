Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 29E05B7171
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 01:34:42 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40906160833g1d77466ekf8b8d4350ab32a24@mail.gmail.com>
References: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
	<1245087807.3185.0@antares> <20090616091801.GC21321@pengutronix.de>
	<fa686aa40906160553m2f0e7cc4n644c3893573845f@mail.gmail.com>
	<20090616132005.GD21321@pengutronix.de>
	<fa686aa40906160833g1d77466ekf8b8d4350ab32a24@mail.gmail.com>
Date: Tue, 16 Jun 2009 09:34:38 -0600
Message-ID: <fa686aa40906160834xb2cde48lfa00c0c9767e3ddc@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: multipart/alternative; boundary=001e68378987aaf931046c78e926
Cc: devicetree-discuss@ozlabs.org,
	=?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001e68378987aaf931046c78e926
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Okay, fair enough.  I wasn't paying very close attention when I replied.  It
still seems awkward to me, but not enough to object (ie. It's not
dangerous).

g.

On Jun 16, 2009 7:20 AM, "Wolfram Sang" <w.sang@pengutronix.de> wrote:

> > Grant wondered if we need a bankwidth. IMHO it is needed for now, but I
don't > > know if this i...
Maybe there is a misunderstanding here. I am not talking about Albrecht's
case.
What I replied to your concern is that bankwidth is used(!) in the
underlying
map-ram-driver in mapram_erase() at the moment. Whether this is really
needed
could be discussed perhaps, but is beyond the scope of this patch series
IMHO.
I'd think this can be addressed in a later series, if needed, although this
could mean that the binding will change (bank-width becoming optional).

Regards, Wolfram -- Pengutronix e.K. | Wolfram Sang ...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3nAUACgkQD27XaX1/VRtTkACfW0aUMJHrU3m4DCel0pm5fA6J
WaQAnjGo5fn6JvMHt3Ke/xFTGB1uYT6p
=V9t5
-----END PGP SIGNATURE-----

--001e68378987aaf931046c78e926
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Okay, fair enough.=A0 I wasn&#39;t paying very close attention when I re=
plied.=A0 It still seems awkward to me, but not enough to object (ie. It&#3=
9;s not dangerous).</p>
<p>g.</p>
<p><blockquote type=3D"cite">On Jun 16, 2009 7:20 AM, &quot;Wolfram Sang&qu=
ot; &lt;<a href=3D"mailto:w.sang@pengutronix.de">w.sang@pengutronix.de</a>&=
gt; wrote:<br><br><p><font color=3D"#500050">&gt; &gt; Grant wondered if we=
 need a bankwidth. IMHO it is needed for now, but I don&#39;t
&gt; &gt; know if this i...</font></p>Maybe there is a misunderstanding her=
e. I am not talking about Albrecht&#39;s case.<br>
What I replied to your concern is that bankwidth is used(!) in the underlyi=
ng<br>
map-ram-driver in mapram_erase() at the moment. Whether this is really need=
ed<br>
could be discussed perhaps, but is beyond the scope of this patch series IM=
HO.<br>
I&#39;d think this can be addressed in a later series, if needed, although =
this<br>
could mean that the binding will change (bank-width becoming optional).<br>
<p><font color=3D"#500050">
Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                ..=
.</font></p><br>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.9 (GNU/Linux)<br>
<br>
iEYEARECAAYFAko3nAUACgkQD27XaX1/VRtTkACfW0aUMJHrU3m4DCel0pm5fA6J<br>
WaQAnjGo5fn6JvMHt3Ke/xFTGB1uYT6p<br>
=3DV9t5<br>
-----END PGP SIGNATURE-----<br>
<br></blockquote></p>

--001e68378987aaf931046c78e926--
