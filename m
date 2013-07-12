Return-Path: <tony@bakeyournoodle.com>
Date: Sat, 13 Jul 2013 08:31:42 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Chris Friesen <cbf123@mail.usask.ca>
Subject: Re: error compiling ptrace in current mainline git
Message-ID: <20130712223141.GA14807@thor.bakeyournoodle.com>
References: <51E02E7D.5050304@mail.usask.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <51E02E7D.5050304@mail.usask.ca>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 10:27:41AM -0600, Chris Friesen wrote:
> Hi all,
>=20
> I'm trying to build current mainline git with gcc version 4.4.1 as a
> cross compiler and I'm getting the following:
>=20
>=20
>   CC      arch/powerpc/kernel/ptrace.o
> {standard input}: Assembler messages:
> {standard input}:1619: Error: junk at end of line: `1'

<snip>
=20
> Any ideas on how to deal with this?  Is this a code error or a
> compiler error?

It could be either can you:
a) try the 4.6.3 cross compiler from: https://www.kernel.org/pub/tools/cros=
stool/
b) Try a ppc64_defconfig build.

If the newer compiler with your .config fixes it it's a compiler issue.
If chaning the config with you 4.4.1 compiler fixes it please post you
=2Econfig to see if we can work out what's going on.

Also when you say "current mainline git" I assume you mean the HEAD of
linus's tree not Ben's right?

Yours Tony

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJR4IPNAAoJEEsCiJRY75GKtEcP+wdY+pGx1Yk77tSoOhjcXpg8
Op9lI51zHv8wt733vXBONZOUzMiEhy5RbrYoGYQivKkFemIGi4S1G5JUUm1R+ITW
7tBFUPcSXxx62QaPCNKtBBDoNlzMEbXvpFHbTxeZ8Rzte9ojcMiu4Ha52Rc6c6x3
uOc+W4mrlHIusBB1ZbyQQsR+GRX75Ngg77SMWDDwq+y8tNXxa4YzTMy0ooZeisbx
Yx9Ks2c2VX40DA8jhu5JIimRA/rwiF/US5uSbvw3boDWWdx4srrSUhfVXAC8Kp1l
dRPZsXgUCD5qAh67ziekqqfhS3SQnEzyNazYGkZPFl+RpJGt94nOhJsfLb7oo9Ng
1Njq8TXSQSr/7TevRA4mEVhi1GMJngdmSQiQuoBuH5UOQU/zTekvjjR5lWdXzFhe
nWfmHCUXmpdpVSfyNoX18UNagHfyZj9DiyfRTcclO71zhL7bYMIy2U4MAlf9adzi
/EdWkp36kZeO7zWbrZAT2BYDbRT6f+2ShWjefcwvu0o6r3dmzbyxnIFiFoDM2MOI
/ed9lO+p+ATAEjeiddFJo51n/CG+oYHl3IM5qfLkmEDBibYxa7vG69WjMSeACxxl
EHG0Lwd882eE3qsgnUrFVKU/ZB3tzeP78InlLoLptDBvuKRqCyprBt1p8UGrka2w
gPYcGqPkIGNnVe3UQ2WD
=egzJ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
