Message-ID: <001d01c3c923$db2ca3c0$5100a8c0@davey>
From: "Davey" <daveywu@transengines.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <C7FFFEA58B43D311920D0004ACE5333F10E4F46C@amer25.avnet.com> <29449.216.110.51.8.1071877375.squirrel@www.orkun.us> <1072105831.4163.15.camel@localhost.localdomain>
Subject: patch for ibm 405ep emac driver in linux-2.4.22 and 2.4.23
Date: Tue, 23 Dec 2003 15:10:21 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0017_01C3C966.E2006630"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C3C966.E2006630
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

c3RlZmFuLCBNYXR0LA0KDQpTb21lIHRpbWUgYWdvIFN0ZWZhbiBhbmQgSSBoYWQgcmVwb3J0ZWQg
dGhhdCBib3RoIGV0aGVybmV0IGludGVyZmFjZXMgY2Fubm90IHdvcmsgd2VsbCB0b2dldGhlci4g
U29ycnkgSSBoYXZlIGxvc3QgYWxsIG9sZCBtYWlscyB3aGVuIEkgcmVpbnN0YWxsIG15IGNvbXB1
dGVyLg0KV2UgaGF2ZSBmaW5kIHRoYXQgdGhpcyBwcm9ibGVtIGlzIGNhdXNlZCBieSB0aGF0IHRo
ZSBiYXNlIGFkZHJlc3Mgb2YgZWh0MSBpcyB3cm9uZyBzZXQuIEZvbGxvdyBieSBteSBwYXRjaCBm
b3IgbGludXgtMi40LjIyIGFuZCBsaW51eC0yLjQuMjMuIEkgaGF2ZSB0ZXN0IHRoZSBwYXRjaCBh
bmQgaXQgd29yayB3ZWxsLg0KDQpEYXZleSBXdQ0KMjAwMy0xMi0yMw0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KZGlmZiAtTnVyIC9o
b21lL2RhdmV5L2xpbnV4cHBjL2RyaXZlcnMvbmV0L2libV9lbWFjL2libV9vY3BfZW5ldC5jIGli
bV9lbWFjL2libV9vY3BfZW5ldC5jDQotLS0gL2hvbWUvZGF2ZXkvbGludXhwcGMvZHJpdmVycy9u
ZXQvaWJtX2VtYWMvaWJtX29jcF9lbmV0LmMgMjAwMy0xMS0yNCAxNjowNzo0OS4wMDAwMDAwMDAg
KzA4MDANCisrKyBpYm1fZW1hYy9pYm1fb2NwX2VuZXQuYyAyMDAzLTEyLTIxIDE1OjU5OjI2LjAw
MDAwMDAwMCArMDgwMA0KQEAgLTExNTEsNyArMTE1MSw3IEBADQogIHJjID0gcmVxdWVzdF9pcnEo
ZGV2LT5pcnEsIGVtYWNfbWFjX2lycSwgMCwgIk9DUCBFTUFDIE1BQyIsIGRldik7DQogIGlmIChy
YyAhPSAwKQ0KICAgZ290byBiYWlsOw0KLSByYyA9IHJlcXVlc3RfaXJxKGZlcC0+d29sX2lycSwg
ZW1hY193YWtldXBfaXJxLCAwLCAiT0NQIEVNQUMgV2FrZXVwIiwgZGV2KTsNCisgcmMgPSByZXF1
ZXN0X2lycShmZXAtPndvbF9pcnEsIGVtYWNfd2FrZXVwX2lycSwgU0FfU0hJUlEsICJPQ1AgRU1B
QyBXYWtldXAiLCBkZXYpOw0KICBpZiAocmMgIT0gMCkgew0KICAgZnJlZV9pcnEoZGV2LT5pcnEs
IGRldik7DQogICBnb3RvIGJhaWw7DQpAQCAtMTIzNyw2ICsxMjM3LDkgQEANCiAgc3RydWN0IG5l
dF9kZXZpY2UgKm1kaW9fbmRldiA9IE5VTEw7DQogIGludCBjb21tYWNfcmVnID0gMDsNCiAgdTMy
IHBoeV9tYXA7DQorIC8vIGFkZCBieSBsYXJyeSBwb3J0ZXINCisgc3RhdGljIGludCBlbWFjX2lu
ZGV4ID0gMDsNCisgLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLw0KICANCiAgZW1h
Y2RhdGEgPSAoc3RydWN0IG9jcF9mdW5jX2VtYWNfZGF0YSAqKW9jcGRldi0+ZGVmLT5hZGRpdGlv
bnM7DQogIGlmIChlbWFjZGF0YSA9PSBOVUxMKSB7DQpAQCAtMTI5Miw2ICsxMjk1LDE0IEBADQog
IGlmIChyYyAhPSAwKQ0KICAgZ290byBiYWlsOw0KICBjb21tYWNfcmVnID0gMTsNCisgDQorIC8v
YWRkIGJ5IGxhcnJ5IHBvcnRlcg0KKyBlbWFjX2luZGV4ICs9IDE7DQorIGlmKGVtYWNfaW5kZXgg
PT0gMikNCisgew0KKyAgb2NwZGV2LT5kZWYtPnBhZGRyID0gMHhlZjYwMDkwMDsNCisgfQ0KKyAv
Ly8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLw0KIA0KICAvKiBNYXAgb3VyIE1N
SU9zICovDQogIGVwLT5lbWFjcCA9ICh2b2xhdGlsZSBlbWFjX3QgKilpb3JlbWFwKG9jcGRldi0+
ZGVmLT5wYWRkciwgc2l6ZW9mIChlbWFjX3QpKTsNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQo=

------=_NextPart_000_0017_01C3C966.E2006630
Content-Type: application/octet-stream;
	name="ibm_emac.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ibm_emac.patch"

diff -Nur /home/davey/linuxppc/drivers/net/ibm_emac/ibm_ocp_enet.c =
ibm_emac/ibm_ocp_enet.c=0A=
--- /home/davey/linuxppc/drivers/net/ibm_emac/ibm_ocp_enet.c	2003-11-24 =
16:07:49.000000000 +0800=0A=
+++ ibm_emac/ibm_ocp_enet.c	2003-12-21 15:59:26.000000000 +0800=0A=
@@ -1151,7 +1151,7 @@=0A=
 	rc =3D request_irq(dev->irq, emac_mac_irq, 0, "OCP EMAC MAC", dev);=0A=
 	if (rc !=3D 0)=0A=
 		goto bail;=0A=
-	rc =3D request_irq(fep->wol_irq, emac_wakeup_irq, 0, "OCP EMAC =
Wakeup", dev);=0A=
+	rc =3D request_irq(fep->wol_irq, emac_wakeup_irq, SA_SHIRQ, "OCP EMAC =
Wakeup", dev);=0A=
 	if (rc !=3D 0) {=0A=
 		free_irq(dev->irq, dev);=0A=
 		goto bail;=0A=
@@ -1237,6 +1237,9 @@=0A=
 	struct net_device *mdio_ndev =3D NULL;=0A=
 	int commac_reg =3D 0;=0A=
 	u32 phy_map;=0A=
+	// add by larry porter=0A=
+	static int emac_index =3D 0;=0A=
+	//////////////////////////////////=0A=
 	=0A=
 	emacdata =3D (struct ocp_func_emac_data *)ocpdev->def->additions;=0A=
 	if (emacdata =3D=3D NULL) {=0A=
@@ -1292,6 +1295,14 @@=0A=
 	if (rc !=3D 0)=0A=
 		goto bail;=0A=
 	commac_reg =3D 1;=0A=
+	=0A=
+	//add by larry porter=0A=
+	emac_index +=3D 1;=0A=
+	if(emac_index =3D=3D 2)=0A=
+	{=0A=
+		ocpdev->def->paddr =3D 0xef600900;=0A=
+	}=0A=
+	//////////////////////////////////////=0A=
 =0A=
 	/* Map our MMIOs */=0A=
 	ep->emacp =3D (volatile emac_t *)ioremap(ocpdev->def->paddr, sizeof =
(emac_t));=0A=

------=_NextPart_000_0017_01C3C966.E2006630--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
