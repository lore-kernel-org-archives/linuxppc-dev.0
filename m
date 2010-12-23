Return-Path: <syokazuliao@yahoo.com.tw>
Received: from nm2-vm0.bullet.mail.tp2.yahoo.com
	(nm2-vm0.bullet.mail.tp2.yahoo.com [203.188.200.182])
	by ozlabs.org (Postfix) with SMTP id 08DC6B7063
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2010 20:25:14 +1100 (EST)
Message-ID: <735799.88939.qm@web74212.mail.tp2.yahoo.com>
Date: Thu, 23 Dec 2010 15:38:31 +0800 (CST)
From: syokazuliao@yahoo.com.tw
Subject: Re: [Cbe-oss-dev] [RFC 0/3] powerpc: memory copy routines tweaked for
	Cell
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-834038811-1293089911=:88939"
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

--0-834038811-1293089911=:88939
Content-Type: multipart/alternative; boundary="0-388117525-1293089911=:88939"

--0-388117525-1293089911=:88939
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,=0AI'm a new Cell BE=C2=A0user, and my=C2=A0debug platform is Y=
DL6.2 run on PS3.=0A=0AI wrote=C2=A0two simple test=C2=A0programs that=C2=
=A0tests=C2=A0Mark Nelson's=C2=A0memcpy routines under=0Aa number of condit=
ions, and the test=C2=A0arrays=C2=A0are=C2=A0aligned on 128-byte boundaries=
.=0A=0AFollowing explains my three files.=0A1. The main1.C is my=C2=A0first=
 test program, it assigns=C2=A0two 16KB arrays.=0A2. The main2.C is my seco=
nd test program, it assigns=C2=A0two 4KB arrays.=0A3. The test_result.TXT i=
s my test result.=0A=0ATherefore, I have=C2=A0three questions.=0A1. How to =
calculate the bandwidth (MB/s)?=0A2. Is my result or test way=C2=A0correct?=
=0A3. Why is the 4KB result different between main1.C and main2.C?=0A=0APS:=
 Please use UltraEdit open my three=C2=A0flies.=0A=0A=0A      
--0-388117525-1293089911=:88939
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif,=
 =E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;font-size:12pt"><DIV style=3D"FONT-FA=
MILY: times new roman, new york, times, serif, =E6=96=B0=E7=B4=B0=E6=98=8E=
=E9=AB=94; FONT-SIZE: 12pt">=0A<DIV style=3D"FONT-FAMILY: times new roman, =
new york, times, serif, =E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94; FONT-SIZE: 12=
pt">=0A<DIV style=3D"FONT-FAMILY: times new roman, new york, times, serif, =
=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94; FONT-SIZE: 12pt">=0A<DIV>Hi everyone,=
</DIV>=0A<DIV>I'm a new Cell BE&nbsp;user, and my&nbsp;debug platform is YD=
L6.2 run on PS3.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I wrote&nbsp;two simple t=
est&nbsp;programs that&nbsp;tests&nbsp;Mark Nelson's&nbsp;memcpy routines u=
nder<BR>a number of conditions, and the test&nbsp;arrays&nbsp;are&nbsp;alig=
ned on 128-byte boundaries.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>=0A<DIV class=
=3Dabstr>Following explains my three files.</DIV>=0A<DIV class=3Dabstr>1. T=
he main1.C is my&nbsp;first test program, it assigns&nbsp;two 16KB arrays.<=
/DIV>=0A<DIV class=3Dabstr>2. The main2.C is my second test program, it ass=
igns&nbsp;two 4KB arrays.</DIV></DIV>=0A<DIV>3. The test_result.TXT is my t=
est result.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Therefore, I have&nbsp;three q=
uestions.</DIV>=0A<DIV>1. How to calculate the bandwidth (MB/s)?</DIV>=0A<D=
IV>2. Is my result or test way&nbsp;correct?</DIV>=0A<DIV>3. Why is the 4KB=
 result different between main1.C and main2.C?</DIV>=0A<DIV>&nbsp;</DIV>=0A=
<DIV>PS: Please use UltraEdit open my three&nbsp;flies.</DIV></DIV></DIV></=
DIV></div><br>=0A=0A=0A=0A      &nbsp;</body></html>
--0-388117525-1293089911=:88939--

--0-834038811-1293089911=:88939
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

--0-834038811-1293089911=:88939
Content-Type: text/plain; name="test_result.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_result.TXT"

Q29weSBNZW1vcnktdG8tTWVtb3J5LCByZXN1bHRzIGFyZSBpbiB0aWNrcy4N
Cg0KICAgICAgICAgICAgIDE2S0IgICAgICAgIDRLQiAgICAgMktCICAgIDFL
QiAgICA1MTJCICAgICAyNTZCICAgICAxMjhCICAgIDY0QiAgICAgMzJCICAg
ICAxNkIgDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KbWFpbjEuQwkJMjA2M34yNDY2CSAgIDY2OX44NzkJNjB+NjMJIDMz
fjM2CSAyMn4yNAkgIDE5fjIxCQkxN34yMQkJMTd+MTkJCTE1fjE3CQkxNX4x
Ng0KbWFpbjIuQwkJCQkJCQkgICAxMTB+MTE0CTYwfjYyCSAzM34zNgkgMjF+
MjQJCTE5fjIxCQkxN34xOAkJMTd+MTgJCTE1fjE2CQkxNX4xNg==

--0-834038811-1293089911=:88939
Content-Type: text/plain; name="test_result.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_result.TXT"

Q29weSBNZW1vcnktdG8tTWVtb3J5LCByZXN1bHRzIGFyZSBpbiB0aWNrcy4N
Cg0KICAgICAgICAgICAgIDE2S0IgICAgICAgIDRLQiAgICAgMktCICAgIDFL
QiAgICA1MTJCICAgICAyNTZCICAgICAxMjhCICAgIDY0QiAgICAgMzJCICAg
ICAxNkIgDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KbWFpbjEuQwkJMjA2M34yNDY2CSAgIDY2OX44NzkJNjB+NjMJIDMz
fjM2CSAyMn4yNAkgIDE5fjIxCQkxN34yMQkJMTd+MTkJCTE1fjE3CQkxNX4x
Ng0KbWFpbjIuQwkJCQkJCQkgICAxMTB+MTE0CTYwfjYyCSAzM34zNgkgMjF+
MjQJCTE5fjIxCQkxN34xOAkJMTd+MTgJCTE1fjE2CQkxNX4xNg==

--0-834038811-1293089911=:88939--
