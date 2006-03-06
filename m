Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D96467B4A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Mar 2006 23:36:18 +1100 (EST)
Subject: Re: How to quickly write cleanmarkers to jffs2 partitions?
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
In-Reply-To: <200603031008.20075.mathieu.deschamps@com2gether.net>
References: <200603021706.14618.david.jander@protonic.nl>
	<200603031008.20075.mathieu.deschamps@com2gether.net>
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-Yf0bB0Bm1xcgZP8SEwB1"
Date: Mon, 06 Mar 2006 13:21:24 +0100
Message-Id: <1141647684.23522.7.camel@linpc041.aimsys.nl>
Mime-Version: 1.0
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-Yf0bB0Bm1xcgZP8SEwB1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-03 at 10:08 +0100, Mathieu Deschamps wrote:

> Hi,
>=20
> "When preparing a flash partition for JFFS2, it is recommended to put=20
> cleanmarkers to the erased blocks.
> This might be done my means of "-j" option of the "flash_eraseall" MTD=20
> utility. Otherwise, JFFS2 will re-erase the blocks
> which contain all 0xFF and have no cleanmarker. This is an unneeded wasti=
ng of=20
> time."
>=20
> Source : http://www.linux-mtd.infradead.org/faq/jffs2.html
>=20
> does this may be relevant ?

This is correct, however flash_eraseall does also (as it's
name suggests, erase all flash blocks, which takes
some time on NOR flash. If you 'know' the flash is erased,
it's not needed.
I used flash_eraseall to write the cleanmarkers, but without
erasing blocks (and called that utility cleanmark)

Jaap-Jan

>=20
>=20
>=20
> Best Regards,
>=20
>=20
> Mathieu Deschamps.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=-Yf0bB0Bm1xcgZP8SEwB1
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIID/DCCA/gw
ggNhoAMCAQICAQwwDQYJKoZIhvcNAQEEBQAwgaMxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29y
ZCBIb2xsYW5kMRIwEAYDVQQHEwlIaWx2ZXJzdW0xFzAVBgNVBAoTDkFpbVZhbGxleSBCLlYuMRww
GgYDVQQLExNTZWN1cml0eSBEZXBhcnRtZW50MTEwLwYDVQQDEyhBaW1WYWxsZXkgUm9vdCBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eSAxMB4XDTA1MDcwMzE5MTQ0NVoXDTA2MDcwMzE5MTQ0NVowgawx
CzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29yZCBIb2xsYW5kMRIwEAYDVQQHEwlIaWx2ZXJzdW0x
FzAVBgNVBAoTDkFpbVZhbGxleSBCLlYuMRwwGgYDVQQLExNTZWN1cml0eSBEZXBhcnRtZW50MRkw
FwYDVQQDFBBqamJvb3JAYWltc3lzLm5sMR8wHQYJKoZIhvcNAQkBFhBqamJvb3JAYWltc3lzLm5s
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSaQ+TlMoyr4eU0v+pTPEwdQVaOvZaVstPT4HO
Bs1ZpCudyz/d5uXbjWUqhVZXN9RmjUsYqOpTerOmdKLGQG+iF0V04G6HgkFGGwSNOYzIPggbjBCp
Od73z50VUaSEJIx7biCkii/HCEQtjMNHE43x7E6BQHsFlwxcZVxXpwTmjwIDAQABo4IBLzCCASsw
CQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUw
HQYDVR0OBBYEFNI9c+sPawUOChOJkpIcB4lloJAxMIHQBgNVHSMEgcgwgcWAFLQ7l4QR8t4pz5gw
b3NBgNlqWk7HoYGppIGmMIGjMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQgSG9sbGFuZDES
MBAGA1UEBxMJSGlsdmVyc3VtMRcwFQYDVQQKEw5BaW1WYWxsZXkgQi5WLjEcMBoGA1UECxMTU2Vj
dXJpdHkgRGVwYXJ0bWVudDExMC8GA1UEAxMoQWltVmFsbGV5IFJvb3QgQ2VydGlmaWNhdGlvbiBB
dXRob3JpdHkgMYIBADANBgkqhkiG9w0BAQQFAAOBgQA5e6p8IA8odS5Hjk8VJVLZgHABYpnUs/Ld
yFzTEpDtRFwINLUiViq72FwBYVKIQQJHaE5l+mYhw5y9TB1gXRLxyPUxyqExWh92VPVhSzKPN9Rk
IXZ65OIr+j5PXLfSEM6zm0Iv1yKcTjUNnh+P4Se9fln3yVUtxr1opZMsr0RCsjGCAa8wggGrAgEB
MIGpMIGjMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQgSG9sbGFuZDESMBAGA1UEBxMJSGls
dmVyc3VtMRcwFQYDVQQKEw5BaW1WYWxsZXkgQi5WLjEcMBoGA1UECxMTU2VjdXJpdHkgRGVwYXJ0
bWVudDExMC8GA1UEAxMoQWltVmFsbGV5IFJvb3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMQIB
DDAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDYwMzA2MTIyMTI0WjAjBgkqhkiG9w0BCQQxFgQUXRuOL/pe1/ArV6+52ruhlTbCZEAwDQYJKoZI
hvcNAQEBBQAEgYBTINVMX8toDMTjWAcxu/I1EOevHASzgdy+xBkzyk7oAqQ3ZG9rbQhqv76Q73HE
MMkCKsVwvsbumHwVO84m5BwUT5U+rj3IhkEKkEDTBhzuIv1vuiFx0s0iBia564VPKr/x9qfFYcIn
DE9sMs/kkaYsgOZP2j49o3Dy+BtNe1N/4QAAAAAAAA==


--=-Yf0bB0Bm1xcgZP8SEwB1--
