Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7578C2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 01:58:45 +1100 (EST)
Date: Tue, 3 Dec 2013 14:58:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131203145833.GV27568@sirena.org.uk>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bVsR27XclOPPgt1U"
In-Reply-To: <1386067087-12243-1-git-send-email-b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement symmetric_channels and
 symmetric_samplebits
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bVsR27XclOPPgt1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 06:38:07PM +0800, Nicolin Chen wrote:
> Since we introduced symmetric_channels and symmetric_samplebits, we implement
> these two features to fsl_ssi so as to drop some no-more-needed code and make
> the driver neat and clean.

Applied, thanks.

--bVsR27XclOPPgt1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfGVAAoJELSic+t+oim9D/kP+gK6ydmP765EsSJAvSrl+oFr
qDaUtCcDzJJ+f/8DtyUp2ZIUE6f4PdafqMZW4R8cLx3t7dkDQtty84ObwvlAqdcN
WHNbhglXvm8OmcNwo7iCu7Sf7WpKMHA3adDnPCXdMuzcfpkRh06V8idNJO5s1xtn
yykJDnOtZ9GstKN6ytChh8re4jLyPHTQn59G/vkuOFTc2rx1VtrEmz9Hito8VLew
PGFj9H8VjKEyx5amPmIdG4PvEVn+I8dGQt2G2Ye6jxyzgMzXB5XxfCLvhRnfuGOy
qeA/+aozKUQLbP7ZYcdQOS0WsDVD9bibZzKgCq2qhS/l4kpJig5FRifYaA/44uQg
dAM7eDokNOpLYsFWg+t9yXEW6C5F+svLuTrfaWBc3Bwc9c2gUWNT+S3TuN0pdtgC
D2LhIKJgCOAP6BHGLIJ0sMErhsozEn+yXV0ylv91J90L5YHgvsofBEpuV6pWmfBb
qhyGOi9lWQ72+aeIWJSYOJd4KgTisUuMzjKKtmwaB924KOa0YDlDXFM72NJiWMKD
Q9GSNa3xRcBFMWilspZHS22If2LchLfHg8N2X7tNgdVJiLY+3/yq1caEW+n5kljZ
tEpAmxPkyEp1jilc3PG+8kc9nOqDitQ1iI3wLZ/8bKOGnCSdcudNb+klDtebGkiR
phISjL2pMu/zSMFgIq0b
=ig8r
-----END PGP SIGNATURE-----

--bVsR27XclOPPgt1U--
