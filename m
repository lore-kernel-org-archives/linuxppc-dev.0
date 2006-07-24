Return-Path: <michael@ellerman.id.au>
Subject: Re: mpic discovery on JS20
From: Michael Ellerman <michael@ellerman.id.au>
To: Amos Waterland <apw@us.ibm.com>
In-Reply-To: <20060720231601.GA24736@kvasir.watson.ibm.com>
References: <20060720231601.GA24736@kvasir.watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IDUrTaFTeLe3cw+oNnXl"
Date: Mon, 24 Jul 2006 17:41:36 +1000
Message-Id: <1153726896.12748.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IDUrTaFTeLe3cw+oNnXl
Content-Type: multipart/mixed; boundary="=-89aMF3nY3Pp8HYI9UcGY"


--=-89aMF3nY3Pp8HYI9UcGY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-07-20 at 19:16 -0400, Amos Waterland wrote:
> Current Linus and Paulus trees do this on JS20 blades with SLOF:
>=20
>  Failed to locate the MPIC interrupt controller
>  PID hash table entries: 4096 (order: 12, 32768 bytes)
>  Maple: Found RTC at IO 0x1070
>  cpu 0x0: Vector: 700 (Program Check) at [c00000007ef83ab0]
>      pc: c00000000002e0c8: .mpic_request_ipis+0x34/0xc8
>      lr: c00000000036b484: .smp_mpic_probe+0x3c/0x58
>      sp: c00000007ef83d30
>     msr: 9000000000029032
>    current =3D 0xc00000000194d610
>    paca    =3D 0xc00000000038f180
>      pid   =3D 1, comm =3D swapper
>  kernel BUG in mpic_request_ipis at arch/powerpc/sysdev/mpic.c:1132!

Does this help?

cheers


--=-89aMF3nY3Pp8HYI9UcGY
Content-Disposition: inline; filename=mpic-fixup.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=mpic-fixup.patch; charset=UTF-8

SW5kZXg6IHRvLW1lcmdlL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvbWFwbGUvc2V0dXAuYw0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KLS0tIHRvLW1lcmdlLm9yaWcvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9tYXBsZS9z
ZXR1cC5jDQorKysgdG8tbWVyZ2UvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9tYXBsZS9zZXR1cC5j
DQpAQCAtMjE2LDYgKzIxNiw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBtYXBsZV9pbml0X0lSUSh2
b2lkKQ0KIAlpbnQgbmFkZHIsIG4sIGksIG9wcGxlbiwgaGFzX2lzdXMgPSAwOw0KIAlzdHJ1Y3Qg
bXBpYyAqbXBpYzsNCiAJdW5zaWduZWQgaW50IGZsYWdzID0gTVBJQ19QUklNQVJZOw0KKwljaGFy
ICp0eXBlcDsNCiANCiAJLyogTG9jYXRlIE1QSUMgaW4gdGhlIGRldmljZS10cmVlLiBOb3RlIHRo
YXQgdGhlcmUgaXMgYSBidWcNCiAJICogaW4gTWFwbGUgZGV2aWNlLXRyZWUgd2hlcmUgdGhlIHR5
cGUgb2YgdGhlIGNvbnRyb2xsZXIgaXMNCkBAIC0yMjYsOSArMjI3LDE5IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCBtYXBsZV9pbml0X0lSUSh2b2lkKQ0KIAkJYnJlYWs7DQogCX0NCiAJaWYgKG1waWNf
bm9kZSA9PSBOVUxMKSB7DQotCQlwcmludGsoS0VSTl9FUlINCi0JCSAgICAgICAiRmFpbGVkIHRv
IGxvY2F0ZSB0aGUgTVBJQyBpbnRlcnJ1cHQgY29udHJvbGxlclxuIik7DQotCQlyZXR1cm47DQor
CQlmb3JfZWFjaF9ub2RlX2J5X3R5cGUobnAsICJpbnRlcnJ1cHQtY29udHJvbGxlciIpIHsNCisJ
CQl0eXBlcCA9IChjaGFyICopZ2V0X3Byb3BlcnR5KG5wLCAiY29tcGF0aWJsZSIsIE5VTEwpOw0K
KwkJCWlmIChzdHJzdHIodHlwZXAsICJvcGVuLXBpYyIpKSB7DQorCQkJCW1waWNfbm9kZSA9IG5w
Ow0KKwkJCQlicmVhazsNCisJCQl9DQorCQl9DQorDQorCQlpZiAobXBpY19ub2RlID09IE5VTEwp
IHsNCisJCQlwcmludGsoS0VSTl9FUlIgIkZhaWxlZCB0byBsb2NhdGUgdGhlIE1QSUMgaW50ZXJy
dXB0ICINCisJCQkJImNvbnRyb2xsZXJcbiIpOw0KKwkJCXJldHVybjsNCisJCX0NCiAJfQ0KIA0K
IAkvKiBGaW5kIGFkZHJlc3MgbGlzdCBpbiAvcGxhdGZvcm0tb3Blbi1waWMgKi8NCg==


--=-89aMF3nY3Pp8HYI9UcGY--

--=-IDUrTaFTeLe3cw+oNnXl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExHmudSjSd0sB4dIRAsWUAKCOA4nYU/VZEKXJJO2n7NM4PTHsxACfQGfv
2hx7jpFMj7KPKLTL79S952A=
=wuUt
-----END PGP SIGNATURE-----

--=-IDUrTaFTeLe3cw+oNnXl--
