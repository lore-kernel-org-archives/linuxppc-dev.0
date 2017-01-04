Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttzzp1pyDzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:36:38 +1100 (AEDT)
Date: Wed, 4 Jan 2017 18:35:50 +0000
From: Mark Brown <broonie@kernel.org>
To: ccrome <ccrome@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Message-ID: <20170104183550.wxaz7ny5gvr7uxwz@sirena.org.uk>
References: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
 <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
 <CAG5mAdzxUhhwjBLWZw6aX_--oAOB0Mbc3+Do-TpNRPqGcC8YVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="js7rpck5t4ylo6re"
In-Reply-To: <CAG5mAdzxUhhwjBLWZw6aX_--oAOB0Mbc3+Do-TpNRPqGcC8YVQ@mail.gmail.com>
Subject: Re: [PATCH] fsl_ssi: set fifo watermark to more reliable value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--js7rpck5t4ylo6re
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 10:31:42AM -0800, ccrome wrote:

> The subject should be
>=20
> [PATCH] ASoC: fsl_ssi: set fifo watermark to more reliable value
>=20
> Correct?

Yes.

> Should I re-submit?

No, it's fine - if I'm sending one of those mails it'll be fine as I've
actually seen the mail to reply to it, the problem is if I don't see the
mail.

--js7rpck5t4ylo6re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhtQIUACgkQJNaLcl1U
h9BL/wf9FmlKVrOqaGfR7S/ACZ415QM3cazZkyhjxJLTduXOC+//oCcUeB6pV86Z
pLzo4mdgVO3cSST30Gy62XtdBbfOnuwxZOF7CzwyRcDql/65ZPYdusHrbV1grDp7
CsiyMmn1rdKiapnJ8VKo7x9byuPPDhjQRjAUyuTCGD6HzS+J6aEG/++PBpVyvm9W
8uO1acZoeHYIJdJboQ02uGdc5w0RxS1HgSLixlsf5F7vQVyLiyzF2kOkqit+FEPL
9auqpkH9y7gDohibLMTxulovGh7tPg+op/PoskwVhdbE8kCG6JYl9CYjdid+i2sD
1sucAM07GNVkrfB8p+Z7HkqW0KSWJQ==
=NMAY
-----END PGP SIGNATURE-----

--js7rpck5t4ylo6re--
