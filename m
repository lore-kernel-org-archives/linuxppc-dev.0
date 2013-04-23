Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 1951C2C0113
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 12:02:06 +1000 (EST)
Date: Tue, 23 Apr 2013 12:02:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 12/12]  Add /proc interface to control topology updates
Message-Id: <20130423120204.4f4b020bbf41ed57597dcb4f@canb.auug.org.au>
In-Reply-To: <517585DB.9040603@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517585DB.9040603@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__23_Apr_2013_12_02_04_+1000_2seMr2WB82avoDGg"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Apr_2013_12_02_04_+1000_2seMr2WB82avoDGg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 22 Apr 2013 13:47:55 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
> +inline int prrn_is_enabled(void)
> +{
> +	return prrn_enabled;
> +}

We generally leave these "inline"s up to the compiler these days i.e.
remove the "inline".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__23_Apr_2013_12_02_04_+1000_2seMr2WB82avoDGg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRdeucAAoJEECxmPOUX5FEfMsP/ReIqY6AbdQRuRGoZpMZWCLu
31tea/mb8+lx0tZZmKDlm5gXnL9m+rVaWuPUHGZ6WoqrH20Bq4zhg39K4cmi/FoL
U6+Yuk+c6q4hkftIfn60VOFr4uKi6+08noq0xgIOBIIWrhf8lSK+e5Hv9hqd999a
/2lS0zWWa2QF1DeID6lOadBZ8MXDsZQCBPXpS7vnWt22sF1uPdczr0njmr0LcE7X
bK5E5bPk4GG9c3+ordGL2tYhC9J3IGBH05Fb6PN3j7OxIkfckDIVXKNFJBpRAMy/
89A8XkiN2YhMTKqnpADHenrMNh6ByfGspMxJrR/RuqlIzwZTk/s1Ox+zGWolj1x7
ETCZgz9OyRbutxkHLSVhxIfoBVXe5+sdxIbFnYq5oBEXS6njHqfz48xCxEJCJdaE
cjsupjj+2NwgYjEUsP3qNBZyb47IQBPUClp/uxhNGlD+QCt5IMwvR5hwYeMLpyQg
AYuJpyk5hWJZ5+UMgGFVMr/wObX1KpPNP2FsWTKTvVO4zjLGb7E1/iy1yK1MW/uR
tHuaSNrB+smj/qLBGeVokuX2TV6rikPtsVNhSQbP+rq9hQ/pvsEg2mtLIwOowAsv
85e1mASdictSOWGoUfJrZ2J5cQXy9pFohjYPOqS6VcoDZPhrw0KKx5ASHxMKamkK
1MkNEbmuvtmxJjU6jEd/
=k4io
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Apr_2013_12_02_04_+1000_2seMr2WB82avoDGg--
