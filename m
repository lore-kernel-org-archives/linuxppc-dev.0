Date: Mon, 2 Apr 2001 10:05:35 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: Denis <denis.muquardt@chello.be>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 3dfx kernel patch
In-Reply-To: <20010403010620.Postino-017265@smtp01.highway.ne.jp>
Message-ID: <Pine.BSF.4.32.0104021003480.40704-200000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1729496514-986231135=:40704"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1729496514-986231135=:40704
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 3 Apr 2001, Kaoru Fukui wrote:

> >video=tdfx:
>
> The name is worng,It's tdfxfb.
> But I don't have the card.

No, the name is correct.  Arguments for the tdfxfb driver use
"video=tdfx:...."

The attatched patch will fix the "mirrored" text, but you *must* boot with
"video=tdfx:noaccel" as this patch doesn't have the character endian
swapping.


ani

--0-1729496514-986231135=:40704
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tdfxfb.diff"
Content-ID: <Pine.BSF.4.32.0104021005350.40704@shell.unixbox.com>
Content-Description: 
Content-Disposition: attachment; filename="tdfxfb.diff"
Content-Transfer-Encoding: BASE64

LS0tIHRkZnhmYi5jLm9yaWcJTW9uIEFwciAgMiAwMzowOToxNCAyMDAxDQor
KysgdGRmeGZiLmMJTW9uIEFwciAgMiAwMzoxODo0OCAyMDAxDQpAQCAtMjc5
LDYgKzI3OSw3IEBADQogICB1bnNpZ25lZCBsb25nIGNsaXAxbWF4Ow0KICAg
dW5zaWduZWQgbG9uZyBzcmNiYXNlOw0KICAgdW5zaWduZWQgbG9uZyBkc3Ri
YXNlOw0KKyAgdW5zaWduZWQgbG9uZyBtaXNjaW5pdDA7DQogfTsNCiANCiBz
dHJ1Y3QgdGRmeGZiX3BhciB7DQpAQCAtOTIxLDYgKzkyMiw3IEBADQogICB0
ZGZ4X291dGwoVklEREVTS1NUQVJULCAgcmVnLT5zdGFydGFkZHIpOw0KICAg
dGRmeF9vdXRsKFZJRFBST0NDRkcsICAgIHJlZy0+dmlkY2ZnKTsNCiAgIHRk
Znhfb3V0bChWR0FJTklUMSwgICAgICByZWctPnZnYWluaXQxKTsgIA0KKyAg
dGRmeF9vdXRsKE1JU0NJTklUMCwJICAgcmVnLT5taXNjaW5pdDApOw0KIA0K
ICAgYmFuc2hlZV9tYWtlX3Jvb20oOCk7DQogICB0ZGZ4X291dGwoU1JDQkFT
RSwgICAgICAgICByZWctPnNyY2Jhc2UpOw0KQEAgLTE0MTEsNiArMTQxMywy
NiBAQA0KIA0KICAgcmVnLnNjcmVlbnNpemUgPSBwYXItPndpZHRoIHwgKHBh
ci0+aGVpZ2h0IDw8IDEyKTsNCiAgIHJlZy52aWRjZmcgJj0gflZJRENGR19I
QUxGX01PREU7DQorDQorICByZWcubWlzY2luaXQwID0gdGRmeF9pbmwoTUlT
Q0lOSVQwKTsNCisNCisjaWYgZGVmaW5lZChfX0JJR19FTkRJQU4pDQorICBz
d2l0Y2ggKHBhci0+YnBwKSB7DQorICAgIGNhc2UgODoNCisgICAgICByZWcu
bWlzY2luaXQwICY9IH4oMSA8PCAzMCk7DQorICAgICAgcmVnLm1pc2Npbml0
MCAmPSB+KDEgPDwgMzEpOw0KKyAgICAgIGJyZWFrOw0KKyAgICBjYXNlIDE2
Og0KKyAgICAgIHJlZy5taXNjaW5pdDAgfD0gKDEgPDwgMzApOw0KKyAgICAg
IHJlZy5taXNjaW5pdDAgfD0gKDEgPDwgMzEpOw0KKyAgICAgIGJyZWFrOw0K
KyAgICBjYXNlIDI0Og0KKyAgICBjYXNlIDMyOg0KKyAgICAgIHJlZy5taXNj
aW5pdDAgfD0gKDEgPDwgMzApOw0KKyAgICAgIHJlZy5taXNjaW5pdDAgJj0g
figxIDw8IDMxKTsNCisgICAgICBicmVhazsNCisgIH0NCisjZW5kaWYNCiAN
CiAgIGRvX3dyaXRlX3JlZ3MoJnJlZyk7DQogDQo=
--0-1729496514-986231135=:40704--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
