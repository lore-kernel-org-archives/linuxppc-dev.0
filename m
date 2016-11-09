Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDMCv1tQtzDvPr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 21:02:03 +1100 (AEDT)
Date: Wed, 9 Nov 2016 10:18:33 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Kumar Gala <galak@codeaurora.org>,
 Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 Minghuan Lian <minghuan.lian@nxp.com>
Subject: Re: [v16, 0/7] Fix eSDHC host version register bug
Message-ID: <20161109091832.GC1807@katana>
References: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
In-Reply-To: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Can you please update your CC list? There is nothing i2c related in this
patch series, so you could drop the i2c-list.


--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIunoAAoJEBQN5MwUoCm2JCAP/0clLR2IchSWDZ0rRwfbLcAL
aKM/ckNIlHdPmOCq/KnJcPpGux4l6J+WkODLGpCJSMJzI0/WwjPIcNGITaapo7Ue
U0NlY49zQ6scE9OMwsCwW22Ao5sArOi+6PAZSjmXYMN2+a+k+AnnWc+mmVmHZ9Y4
lWVeksXVm4Lg2xEtq84ceXOpatb/4KE3M3iOKgcg+9T+Fro+/NnTjf+AkuF9Xkay
jNqGoOdeIzD2WvrjCRD7+ApBfZZyz/Za89cGtkTvK69QqON6HB6xiesDF/YbPoz3
UYn91ab+/teyAvoN5kDHaRcEQT2L47rQPY2hh26eCV4pyepp+23sAZ9nMakYOZRl
rV7/ZBUh6GvyUSxDW8ud/G/O52wbdSObyBjj+qUhCQ5LjtHgcaSZwg8/Brml7YsS
NO205lIMOsjGiB+vs9N1QhApga6Rcamb3RgIeg3un6gHCFsqnG3xEyeEDhYNNzia
AIa+xhQ/8MAps3yjGQDp3rDJ+kxzn1qHfsEBCkOEloGsDlKt1L8R9t/05/dYwJGd
7aKyLlhCXMGbdgzKxPcWNCiKm/UP+pZns4ABDJA8Gi9xkkEJrcr87IQ070M8N4if
gMRmGS8Q4Yr7MXLC44C2+aStjQWk/058IuKXV/oGHvrj3Buh+IKBl4GazD2tECj5
gmp4R7RKlYgaZUklTDQT
=Bmj3
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
