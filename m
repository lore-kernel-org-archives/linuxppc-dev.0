Return-Path: <zjznliang_popo@163.com>
Received: from 163.com (bj44-206.i.netease.com [202.108.44.206])
	by ozlabs.org (Postfix) with SMTP id CE1FD68763
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 16:41:09 +1100 (EST)
Received: from zjzn (unknown [61.183.211.137])
	by smtp3 (Coremail) with SMTP id KUA8W1RxeUOeNpkA.1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 13:25:43 +0800 (CST)
Date: Tue, 15 Nov 2005 13:26:20 +0800
From: "zjznliang" <zjznliang_popo@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20051115054109.CE1FD68763@ozlabs.org>
Subject: interrupts limit??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SGkgLGxpbnV4cHBjLWVtYmVkZGVkIKOhDQoNCgkJICBJIGhhdmUgZG9uZSB0aGUgaW50ZXJydXB0
IHJlcXVlc3QgYnkgcmVxdWVzdF9pcnEoKSBvbiB0aGUgTGludXggMi40LjI1ICx3aGVuIHR5cGlu
ZyB0aGUgJ2NhdCAvcHJvYy9pbnRlcnJ1cHRzJywgSSBjYW4gc2VlIHRoZSBpbmZvcm1hdGlvbiBh
cyBmb2xsb3cgOg0KDQovcHJvYyAjIGNhdCBpbnRlcnJ1cHRzDQogICAgICAgICAgIENQVTANCiAg
MjogICAgICAgMzQyMCAgIDh4eCBTSVUgICBFZGdlICAgICAgd2JnYV9pbnRlcnJ1cHQNCiAgNTog
ICAgICAgICAgMCAgIDh4eCBTSVUgICBFZGdlICAgICAgQ1BNIGNhc2NhZGUNCiAxNTogICAgICAg
ICAgMCAgIDh4eCBTSVUgICBFZGdlICAgICAgdGJpbnQNCiAxNjogICAgICAgICAgMCAgIENQTSAg
ICAgICBFZGdlICAgICAgZXJyb3INCiAyMDogICAgICAgIDgwMSAgIENQTSAgICAgICBFZGdlICAg
ICAgU01DMQ0KDQphbmQgSSBjYW4gc2VlIHRoZSBudW1iZXIgb2Ygd2JnYV9pbnRlcnJ1cHQgaXMg
aW5jcmVhc2luZy4gQnV0IGEgZmV3IG1pbnV0ZXMgbGF0ZXIgLHRoZSBudW1iZXIgaXMgbG9ja2Vk
IGF0IDEyODAwMCBhcyBmb2xsb3c6DQoNCi9wcm9jICMgY2F0IGludGVycnVwdHMNCiAgICAgICAg
ICAgQ1BVMA0KICAyOiAgICAgMTI4MDAwICAgOHh4IFNJVSAgIEVkZ2UgICAgICB3YmdhX2ludGVy
cnVwdA0KICA1OiAgICAgICAgICAwICAgOHh4IFNJVSAgIEVkZ2UgICAgICBDUE0gY2FzY2FkZQ0K
IDE1OiAgICAgICAgICAwICAgOHh4IFNJVSAgIEVkZ2UgICAgICB0YmludA0KIDE2OiAgICAgICAg
ICAwICAgQ1BNICAgICAgIEVkZ2UgICAgICBlcnJvcg0KIDIwOiAgICAgICAgODMzICAgQ1BNICAg
ICAgIEVkZ2UgICAgICBTTUMxDQoNCmFuZCB0aGVyZSBpcyBubyB3YmdhX2ludGVycnVwdCBhbnkg
bW9yZS4uLi53aGF0J3MgdGhlIG1hdHRlciB3aXRoIHRoZSBpbnRlcnJ1cHQ/d2h5IGlzIDEyODAw
MD8/PyANCg0KDQqhoaGhemp6bmxpYW5nDQqhoaGhoaGhoaGhoaGhoaGhemp6bmxpYW5nX3BvcG9A
MTYzLmNvbQ0KoaGhoaGhoaGhoaGhoaGhoaGhoaEyMDA1LTExLTE1DQo=
