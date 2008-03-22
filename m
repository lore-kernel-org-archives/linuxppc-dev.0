Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 2AFC3DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Mar 2008 22:51:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: Re: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
Date: Sat, 22 Mar 2008 12:51:41 +0100
Message-ID: <46CAC1281D7CB94A9AEFFB131F9569CA227627@tmnt04.transmode.se>
References: <>
	<1205853088-30171-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<989B956029373F45A0B8AF029708189001D19565@zch01exm26.fsl.freescale.net>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang" <LeoLi@freescale.com>, "Netdev" <netdev@vger.kernel.org>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IG5ldGRldi1vd25lckB2Z2Vy
Lmtlcm5lbC5vcmcNCj4+IFttYWlsdG86bmV0ZGV2LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24g
QmVoYWxmIE9mIEpvYWtpbSBUamVybmx1bmQNCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTgsIDIw
MDggMTE6MTEgUE0NCj4+IFRvOiBOZXRkZXY7IExpIFlhbmcNCj4+IENjOiBKb2FraW0gVGplcm5s
dW5kDQo+PlN1YmplY3Q6IFtQQVRDSF0gdWNjX2dldGg6IEFkZCA4IGJ5dGVzIHRvIG1heCBUWCBm
cmFtZSBmb3IgVkxBTnMNCj4+DQo+PiBDcmVhdGluZyBhIFZMQU4gaW50ZXJmYWNlIG9uIHRvcCBv
ZiB1Y2NfZ2V0aCBhZGRzIDQgYnl0ZXMgdG8NCj4+IHRoZSBmcmFtZSBhbmQgdGhlIEhXIGNvbnRy
b2xsZXIgaXMgbm90IHByZXBhcmVkIHRvIFRYIGEgZnJhbWUNCj4+IGJpZ2dlciB0aGFuIDE1MTgg
Ynl0ZXMgd2hpY2ggaXMgNCBieXRlcyB0b28gc21hbGwgZm9yIGEgZnVsbA0KPj4gVkxBTiBmcmFt
ZS4gQWxzbyBhZGQgNCBleHRyYSBieXRlcyBmb3IgZnV0dXJlIGV4cGFuc2lvbi4NCj4gDQo+IElN
TywgVkxBTiBhbmQgSnVtYm8gcGFja2V0IHN1cHBvcnQgaXMgbm90IGdlbmVyYWwgY2FzZSBvZiBF
dGhlcm5ldC4NCj4gQ291bGQgeW91IG1ha2UgdGhpcyBjaGFuZ2Ugb3B0aW9uYWw/ICBUaGFua3Mu
DQo+IA0KPiAtIExlbyANCg0KaG1tLCBJIGRvIG5vdCBhZ3JlZS4gVkxBTiBpcyBjb21tb24gdG9k
YXkuDQoNCklmIHlvdSB3ZXJlIHRvIGVuYWJsZSBIVyBzdXBwb3J0IGZvciBWTEFOIHRoZW4gdGhl
IGV0aGVybmV0IGNvbnRyb2xsZXIgd291bGQgaW5qZWN0IGFuIGV4dHJhIDQgYnl0ZXMgaW50byB0
aGUgZnJhbWUuIA0KVGhpcyBjaGFuZ2UgZG9lcyBub3QgY2hhbmdlIHRoZSB2aXNpYmxlIE1UVSBm
b3IgdGhlIHVzZXIuIEFzIGlzIG5vdywgc29mdCBWTEFOIGlzIHNpbGVudGx5IGJyb2tlbi4gRG8g
eW91DQpyZWFsbHkgd2FudCB0aGUgdXNlciB0byBmaW5kIGFuZCB0dXJuIG9uIGEgY29udHJvbGxl
ciBzcGVjaWZpYyBmZWF0dXJlIHRvIHVzZSBWTEFOPw0KDQpXaGF0IGRvZXMgbmV0ZGV2IHBlb3Bs
ZSB0aGluaz8gDQoNCiBKb2NrZSANCg0KDQo=
