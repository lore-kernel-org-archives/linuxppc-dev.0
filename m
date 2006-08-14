Return-Path: <streeter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id D57AC67BB9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 03:18:19 +1000 (EST)
Subject: Re: Can red hat linux be ported to Power PC ???????????????
From: Guy Streeter <streeter@redhat.com>
To: Ujwal <ujwal.mailinglist@gmail.com>
In-Reply-To: <b47d45990608140956s1a1dcdbbh8b454d0fe487a271@mail.gmail.com>
References: <b47d45990608140956s1a1dcdbbh8b454d0fe487a271@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-LpBc4z/rcOkpVBWy9+wK"
Date: Mon, 14 Aug 2006 12:18:15 -0500
Message-Id: <1155575895.4044.6.camel@mentos.hsv.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-LpBc4z/rcOkpVBWy9+wK
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-N7w7nZqo9jec5oKrCzpl"


--=-N7w7nZqo9jec5oKrCzpl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-08-14 at 22:26 +0530, Ujwal wrote:
> hi all,
>=20
> can red hat linux(2.4 kernel with a the .config file of ML310 board )
> be ported to PowerPC on a development board?

The ppc arch of the kernel tree was not well maintained in the Red Hat
kernel source for the release that used the 2.4 kernel (Red Hat
Enterprise Linux 3).
I would be surprised if it built, and I'm fairly certain it would not
run.

That being said, Red Hat makes a business in developing its products for
other platforms and might consider the work on a contract basis.

--Guy Streeter


--=-N7w7nZqo9jec5oKrCzpl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE4LBT0Bme0QyNhPQRAu/MAJ9chcXxYuYirLnsG85Iz8GnANOougCdGpmU
D8bTAeBCXRf7GTE0SiR027Q=3D
=3Dxo+n
-----END PGP SIGNATURE-----

--=-N7w7nZqo9jec5oKrCzpl--

--=-LpBc4z/rcOkpVBWy9+wK
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGLTCCAuYw
ggJPoAMCAQICECx80WF8kPxLirzv1ZzAahwwDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MDcxOTIxMTkwOVoXDTA3MDcxOTIxMTkw
OVowSDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjElMCMGCSqGSIb3DQEJARYWZ3V5
LnN0cmVldGVyQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMgJD4hS
Vrm+lRsUrEWFTVW+Wvj40BXayoJ2QX0ICdilOaB31R/2fJPcz6ayJhR2Keqiqs7o61FQmBZEdsl7
vEqgFfimMLI3/dwx95mPB/I88c2rUjvfLKjfuCvfQWRUpXts5nww9xG7CwOpT6Lnslb1nAPPntiK
hJZCCdAH1A1pr4dEBp0cD5LziyQpyG6lphlrK/EZwyzlLh8TWj0pH1hJ+HOedbAD+TYbeXi9TXQQ
3VSXQ9ffHI+trigF6MOBtk04T5ub5iPVQ2Y+3xZYrAj1Zou7CnMWAsqgQnC34kub49jsDATXV/vw
pt8B9K3VeHpyhTRcCuuizmYwaDhlnbkCAwEAAaMzMDEwIQYDVR0RBBowGIEWZ3V5LnN0cmVldGVy
QGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBAFLVAijMcVWrLMhYD9q6
H+0OPn9Ee4xdkaRAqYhfvRJxhx1WROUOZoAuCF14auSsycgMYLXZcG+7Xkj4UGtPtQzhMksGRl/F
q6HSmFlAVRALBikDNQYcdMrpryEKl/sZ+ZSp2nnl5FDhEMIlm4KuCZy/ydqB5iUZb0br7ObakTbL
MIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgT
DFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3Vs
dGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMb
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVl
bWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCB
iQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1os
iRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpU
hQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0f
BDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxD
QS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwy
LTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+q
LZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr3
94fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAfwwggH4AgEBMHYwYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhAsfNFhfJD8S4q879WcwGocMAkG
BSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNjA4
MTQxNzE4MTFaMCMGCSqGSIb3DQEJBDEWBBQ13bEAHEM0bTzdtA+2gTtxacZjVDANBgkqhkiG9w0B
AQEFAASCAQA8HA6s2wNMYa1x6qOQ0TU+LpgFNLMHwa8ajXZSRjwKtEEBey9bESItMNvP4vuFCoGc
n0MJewsAY91hNjXGpfugKU6bX8MLwvljC2BYjYwJK1NH0mqRKgBLq6cMPhM+LbaB5WREqPphZ3SP
3qrGx38O34FnuUHLlDT11lxbOLePDMBqronusQuu1zXN84Vp9/m2YtiKBXUbYa/Pb0wmEar5lH8Y
OhZ1f6WJP36M9K7KyG+d7PinJs4/UG/XVlk54wjdiX2z9gx7AFvSmejoQ0vkN63uJwbRb0qlCmD4
mGXxo9t1EFdYa/uCa8jxfQESVZeCMZD25p7wj9tHUeaWdPifAAAAAAAA


--=-LpBc4z/rcOkpVBWy9+wK--
