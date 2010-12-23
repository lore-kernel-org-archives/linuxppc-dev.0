Return-Path: <syokazuliao@yahoo.com.tw>
Received: from nm1-vm0.bullet.mail.tp2.yahoo.com
	(nm1-vm0.bullet.mail.tp2.yahoo.com [203.188.200.180])
	by ozlabs.org (Postfix) with SMTP id 56565B70E6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2010 18:49:17 +1100 (EST)
Message-ID: <859409.54680.qm@web74208.mail.tp2.yahoo.com>
Date: Thu, 23 Dec 2010 15:49:11 +0800 (CST)
From: syokazuliao@yahoo.com.tw
Subject: Re: [Cbe-oss-dev] [RFC 0/3] powerpc: memory copy routines tweaked for
	Cell
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-160434120-1293090551=:54680"
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-160434120-1293090551=:54680
Content-Type: multipart/alternative; boundary="0-1777524534-1293090551=:54680"

--0-1777524534-1293090551=:54680
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry, I was=C2=A0send wrong files.=0AI send my three files=C2=A0again.=0A=
=0A=0A      
--0-1777524534-1293090551=:54680
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif,=
 =E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;font-size:12pt"><DIV>Sorry, I was&nbs=
p;send wrong files.</DIV>=0A<DIV>I send my three files&nbsp;again.</DIV></d=
iv><br>=0A=0A=0A=0A      &nbsp;</body></html>
--0-1777524534-1293090551=:54680--

--0-160434120-1293090551=:54680
Content-Type: text/plain; name="main1.C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="main1.C"

I2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5j
bHVkZSA8cHB1X2ludHJpbnNpY3MuaD4NCg0KZXh0ZXJuIHZvaWQgKm1lbWNw
eSh2b2lkICosIGNvbnN0IHZvaWQgKiwgc2l6ZV90KTsNCg0KaW50IG1haW4o
KSB7DQoJdW5zaWduZWQgY2hhciAqcywgKmQ7DQoJcmVnaXN0ZXIgdW5zaWdu
ZWQgbG9uZyBsb25nIHN0YXJ0LCBmaW5pc2gsICBpOw0KCWlmKHBvc2l4X21l
bWFsaWduKCh2b2lkICopJnMsIDEyOCwgMTYzODQpKSB7DQoJCXByaW50Zigi
ZmFpbGVkXG4iKTsNCgkJZ290byBlbmQ7DQoJfQ0KCWZvcihpID0gMTI4LCBq
ID0gMDsgaSA+IDA7IGktLSwgaiArPSAxMjgpIHsJCS8qIGNsZWFyIHMgZnJv
bSBjYWNoZSAqLw0KCQlfX2RjYmYocytqKTsNCgl9DQoJaWYocG9zaXhfbWVt
YWxpZ24oKHZvaWQgKikmZCwgMTI4LCAxNjM4NCkpIHsNCgkJcHJpbnRmKCJm
YWlsZWRcbiIpOw0KCQlnb3RvIGVuZDsNCgl9DQoJZm9yKGkgPSAxMjgsIGog
PSAwOyBpID4gMDsgaS0tLCBqICs9IDEyOCkgewkJLyogY2xlYXIgZCBmcm9t
IGNhY2hlICovDQoJCV9fZGNiZihzK2opOw0KCX0NCg0KCV9fZGNidChtZW1j
cHkpOwkJLyogcHJlZmV0Y2ggbWVtY3B5ICovDQoJX19kY2J0KG1lbWNweSsx
MjgpOw0KCV9fZGNidChtZW1jcHkrMjU2KTsNCglfX2RjYnQobWVtY3B5KzM4
NCk7DQoJX19kY2J0KG1lbWNweSs1MTIpOw0KCV9fZGNidChtZW1jcHkrNjQw
KTsNCglfX2RjYnQobWVtY3B5Kzc2OCk7DQoJX19kY2J0KG1lbWNweSs4OTYp
Ow0KCV9fZGNidChtZW1jcHkrMTAyNCk7DQoJX19kY2J0KG1lbWNweSsxMTUy
KTsNCglfX2RjYnQobWVtY3B5KzEyODApOw0KCV9fZGNidChtZW1jcHkrMTQw
OCk7DQoJX19kY2J0KG1lbWNweSsxNTM2KTsNCglfX2RjYnQobWVtY3B5KzE2
NjQpOw0KCV9fZGNidChtZW1jcHkrMTc5Mik7DQoJX19kY2J0KG1lbWNweSsx
OTIwKTsNCglfX2RjYnQobWVtY3B5KzIwNDgpOw0KCV9fZGNidChtZW1jcHkr
MjE3Nik7DQoJX19kY2J0KG1lbWNweSsyMzA0KTsNCglfX2RjYnQobWVtY3B5
KzI0MzIpOw0KCV9fc3luYygpOw0KDQoJc3RhcnQgPSBfX21mdGIoKTsNCglt
ZW1jcHkoZCwgcywgNDA5Nik7DQoJZmluaXNoID0gX19tZnRiKCk7DQoNCglw
cmludGYoIiVsbGRcbiIsIGZpbmlzaCAtIHN0YXJ0KTsNCg0KCWZyZWUocyk7
DQoJZnJlZShkKTsNCmVuZDoNCglyZXR1cm4gMDsNCn0NCg==

--0-160434120-1293090551=:54680
Content-Type: text/plain; name="main2.C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="main2.C"

I2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5j
bHVkZSA8cHB1X2ludHJpbnNpY3MuaD4NCg0KZXh0ZXJuIHZvaWQgKm1lbWNw
eSh2b2lkICosIGNvbnN0IHZvaWQgKiwgc2l6ZV90KTsNCg0KaW50IG1haW4o
KSB7DQoJdW5zaWduZWQgY2hhciAqcywgKmQ7DQoJcmVnaXN0ZXIgdW5zaWdu
ZWQgbG9uZyBsb25nIHN0YXJ0LCBmaW5pc2gsICBpOw0KCWlmKHBvc2l4X21l
bWFsaWduKCh2b2lkICopJnMsIDEyOCwgNDA5NikpIHsNCgkJcHJpbnRmKCJm
YWlsZWRcbiIpOw0KCQlnb3RvIGVuZDsNCgl9DQoJZm9yKGkgPSAzMiwgaiA9
IDA7IGkgPiAwOyBpLS0sIGogKz0gMTI4KSB7CQkvKiBjbGVhciBzIGZyb20g
Y2FjaGUgKi8NCgkJX19kY2JmKHMraik7DQoJfQ0KCWlmKHBvc2l4X21lbWFs
aWduKCh2b2lkICopJmQsIDEyOCwgNDA5NikpIHsNCgkJcHJpbnRmKCJmYWls
ZWRcbiIpOw0KCQlnb3RvIGVuZDsNCgl9DQoJZm9yKGkgPSAzMiwgaiA9IDA7
IGkgPiAwOyBpLS0sIGogKz0gMTI4KSB7CQkvKiBjbGVhciBkIGZyb20gY2Fj
aGUgKi8NCgkJX19kY2JmKHMraik7DQoJfQ0KDQoJX19kY2J0KGNweW1lbSk7
CQkvKiBwcmVmZXRjaCBtZW1jcHkgKi8NCglfX2RjYnQoY3B5bWVtKzEyOCk7
DQoJX19kY2J0KGNweW1lbSsyNTYpOw0KCV9fZGNidChjcHltZW0rMzg0KTsN
CglfX2RjYnQoY3B5bWVtKzUxMik7DQoJX19kY2J0KGNweW1lbSs2NDApOw0K
CV9fZGNidChjcHltZW0rNzY4KTsNCglfX2RjYnQoY3B5bWVtKzg5Nik7DQoJ
X19kY2J0KGNweW1lbSsxMDI0KTsNCglfX2RjYnQoY3B5bWVtKzExNTIpOw0K
CV9fZGNidChjcHltZW0rMTI4MCk7DQoJX19kY2J0KGNweW1lbSsxNDA4KTsN
CglfX2RjYnQoY3B5bWVtKzE1MzYpOw0KCV9fZGNidChjcHltZW0rMTY2NCk7
DQoJX19kY2J0KGNweW1lbSsxNzkyKTsNCglfX2RjYnQoY3B5bWVtKzE5MjAp
Ow0KCV9fZGNidChjcHltZW0rMjA0OCk7DQoJX19kY2J0KGNweW1lbSsyMTc2
KTsNCglfX2RjYnQoY3B5bWVtKzIzMDQpOw0KCV9fZGNidChjcHltZW0rMjQz
Mik7DQoJX19zeW5jKCk7DQoNCglzdGFydCA9IF9fbWZ0YigpOw0KCW1lbWNw
eShkLCBzLCA0MDk2KTsNCglmaW5pc2ggPSBfX21mdGIoKTsNCg0KCXByaW50
ZigiJWxsZFxuIiwgZmluaXNoIC0gc3RhcnQpOw0KDQoJZnJlZShzKTsNCglm
cmVlKGQpOw0KZW5kOg0KCXJldHVybiAwOw0KfQ0K

--0-160434120-1293090551=:54680
Content-Type: text/plain; name="test_result.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_result.TXT"

Q29weSBNZW1vcnktdG8tTWVtb3J5LCByZXN1bHRzIGFyZSBpbiB0aWNrcy4N
Cg0KICAgICAgICAgICAgIDE2S0IgICAgICAgIDRLQiAgICAgMktCICAgIDFL
QiAgICA1MTJCICAgICAyNTZCICAgICAxMjhCICAgIDY0QiAgICAgMzJCICAg
ICAxNkIgDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KbWFpbjEuQyAgIDIwNjN+MjQ2NgkgICA2Njl+ODc5CTYwfjYzCSAz
M34zNgkgMjJ+MjQJICAxOX4yMQkJMTd+MjEJCTE3fjE5CQkxNX4xNwkJMTV+
MTYNCm1haW4yLkMgICAgICAgICAgICAgICAgMTEwfjExNAk2MH42MgkgMzN+
MzYJIDIxfjI0CQkxOX4yMQkJMTd+MTgJCTE3fjE4CQkxNX4xNgkJMTV+MTY=


--0-160434120-1293090551=:54680--
