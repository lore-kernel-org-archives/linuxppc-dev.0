Return-Path: <dja@axtens.net>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 734DC1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 10:55:17 +1000 (AEST)
Received: by payr10 with SMTP id r10so61710417pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 17:55:15 -0700 (PDT)
Message-ID: <1433292866.438.64.camel@axtens.net>
Subject: Re: [PATCH v1 8/9] powerpc/powernv: Add OPAL support for Nest PMU
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stewart
 Smith <stewart@linux.vnet.ibm.com>, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 10:54:26 +1000
In-Reply-To: <1433260778-26497-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-9-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-ObRaLzi/U2/kie2bNaOT"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ObRaLzi/U2/kie2bNaOT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> +int64_t opal_nest_ima_control(uint32_t value);

If I'm understanding things correctly, you call this function in patch
3. Quoting from that patch:
> +static void nest_init(void *dummy)
> +{
> +       opal_nest_ima_control(P8_NEST_ENGINE_START);
> +}
Does this patch need to be moved earlier in the series?=20

Have you tested that the series compiles at every point?=20
(I've found that this can be done quite easily with
 git rebase --interactive using x to run the compile)

> +
>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname=
,
>  				   int depth, void *data);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerp=
c/platforms/powernv/opal-wrappers.S
> index a7ade94..ce36a68 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -295,3 +295,4 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
>  OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
>  OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
>  OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
> +OPAL_CALL(opal_nest_ima_control,		OPAL_NEST_IMA_CONTROL);


--=-ObRaLzi/U2/kie2bNaOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVblBDAAoJEPC3R3P2I92FWzUP/2QCJta57GBCFYcEjQB6ZbCd
/ZWLFoEDUCjAwSHZje2h1ZUYK0VcHjhMEuE1xEl/jxZAiexTilQXa+IPhyOs6T5p
cNJMQ7EdWv7FtOCp5X8OHcQwJ76ITEkomv2ixQhh7mn3C3vy86yvbp6eECmmDOOM
PkJpk3Y0GpugVEz+2roXiqQ7otICO7WZVdxQ6xWxCXppwojqPrx3m2UA8EAI7Z1o
Y6MRa0bcrpNCTfHjOyS0rXrlN+t1srTVWISyg8nQpsnLYkKXXT+W58LdUGIpb1oF
yCtGW+2PqGXSUTXdVPgeHUIyuIo/r5jH1/wl6zXM+uyIkjbD1huHkcMI/RtExm4J
9ixcA54L2q5uV5e8AEXTl6N6b6weRzUlTnUEydQpQlsyLAMW9/s2KQjclsRERxOo
ElvJGlx2wbA4vHBdVznG0aBrUvr5twoJlpdxEq7b7CeBzu39LBOgs/WeOZ6/qeM3
gMkIytldGZ0iALWuaDAUrwPT/X7ZhJ1dolzgUGqjSknjLrC+p2D3q/smp26jVl/H
QqXWQiePv6Klz5zgyi2oY9sGiLx5JCAD2gnDb0gFsUZCtPj1tufOTqWbx+4JPbMm
/hoe0P7TirnxJ9yCys7+xoSag7/1xxvLYi+hJ91cjEsb66jSidAmqjFUm3731Pl8
ckb29n2AIIE5WWSOEjMQ
=CxPj
-----END PGP SIGNATURE-----

--=-ObRaLzi/U2/kie2bNaOT--
