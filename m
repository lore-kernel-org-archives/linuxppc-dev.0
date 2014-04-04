Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 218AA1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 21:05:59 +1100 (EST)
Date: Fri, 4 Apr 2014 11:05:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140404100532.GN14763@sirena.org.uk>
References: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kY0AMSsGPnDJoAXR"
In-Reply-To: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kY0AMSsGPnDJoAXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 03:09:47PM +0800, Nicolin Chen wrote:
> The BCP bit in TCR4/RCR4 register rules as followings:
>   0 Bit clock is active high with drive outputs on rising edge
>     and sample inputs on falling edge.
>   1 Bit clock is active low with drive outputs on falling edge
>     and sample inputs on rising edge.

Applied, thanks.

--kY0AMSsGPnDJoAXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPoPoAAoJELSic+t+oim9cqwP/0eylndow3ZrNrhmze/mgQHS
SQmqXMDPwLQEH3Jb3i+s1KdvLwS318DgsFNfX9pCYNWeDlP/IkTMzNKxSjrEY69V
z+0N5QUkYfUkWkjnAStiWKj40/2Vl/oN1g557czLa6H+1iREbrxS9aOhNj+i7gBh
XgpFSbK84VRzQntlg75Iv5yfbfJ0zW3d/cV+CsJ8IRekGey6hd+r3riaWouUJ4BM
ViflC6ypTht3ahLKPSrOXtI5Y5f+l4ueCdt8xtuv1Aj3EZf8hRaFJTzveDJce+7F
bnIOx/bZv91yJSErE/+28bDcxJN7IkuXJMEgC1x3ktzgOfKACumaQjRfw6qMsaPK
LUDzmT6NXn7ausjWFuFOG45UxOIZiPjUJMqs197hy+opbQRUW03SbHEdlrbO6eNa
kLdCOSJIbjGBxPzx9Q+eXFsmQv7jXcLz464YyQVSTBuPFstF3WliQXpi6VqLXG/9
+NzAmzdhN3j66A1REYK4/B9S+JrwUwo1nPXpp4hOwwQeQlZpwd0q6gmO4wJ7SyHB
kA4CdMuaKBlvulYGXgYytdr8PyVu0/arAWaBgOcECk549z/4T+UHucQI22xchsAG
+R8c43fkxcDMPZRbMgXlIoMeZbZkz0XXicsuV9CXn/iIe69d/Gdq1rj1jKAMaun+
3Fe2Kz9TWQRojvvD8/ba
=HM9U
-----END PGP SIGNATURE-----

--kY0AMSsGPnDJoAXR--
