Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 970B21A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 10:01:51 +1100 (AEDT)
Date: Mon, 16 Mar 2015 10:01:44 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv3] powerpc: convert relocs_check to a shell script using
 grep
Message-ID: <20150315230144.GB39518@thor.bakeyournoodle.com>
References: <20150315220847.1ecfe174@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
In-Reply-To: <20150315220847.1ecfe174@canb.auug.org.au>
Cc: David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2015 at 10:08:47PM +1100, Stephen Rothwell wrote:
> This runs a bit faster and removes another use of perl from
> the kernel build.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I only wrote it in perl because ... lazy.  Kill it with fire.

Acked-By: Tony Breeds <tony@bakeyournoodle.com>

Yours Tony.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVBg9YAAoJEPvNNsFAAoTBFTIP/0uHyhyP/0Y4dsbYP4zHQcpu
Hw9N02twQh7JqkrTMSMVpiYGdYf/6YJnTk86bZDJINPMs5p9XqC34KBcLQe0s8I9
kN8AsYkqz17zEpZcHOVZelOf0igJHUSXjjZ1vQIsCM+TKg2dcKrAK80Q+9SShVwl
R8GT8VLa5Axcz9d9rLvnHGEVX+/pU4lBDZB+qSvJZO/mOQ7EcjnqLkmPX8h1Ghnc
R4zdgKh/tQR7f4Spdtsdspei8hNE9cdBhhpMhn2R4lTm9fT9hSTjvWRS0uLfjE36
7lSTVgtR21NtJTRfIsDozP6SPNv3SKjFoxvX+XEPqEFIyYljnN60KirHBhEi4DiC
GTxSDEyZZR7W2oSduhV+Ob3/Jo/ygUAqjG3K0v448aqq69cyqRbKaoPulawyEVLd
EN+MIURm40uaep2xncHU3IS0onETkzyZyN8aEei4L/YrOx/5D0DMTVdI4nq5cXrd
Qaai5Dkavoc0vjZtCc193ZBvHPBpkHbjOmEIwYeXnATMe2zvyswnB52ViLNOzNJC
tmgm1OzfE8blks62EZjywkNp150qZs0UkRW3LsXw8KuUSX3eNEqtGaWso2xrzRy3
PVVFBDSG8Lx64uWeEQ5OT6XYKRmIdma5gERSta9DZn2jta21+0l7HbxQxrClaNgT
wbMLY6pNmNn+It3aHcp1
=brfC
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
