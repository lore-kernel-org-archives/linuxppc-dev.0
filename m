Return-Path: <B08248@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B549A2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 06:17:36 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Michael Neuling <mikey@neuling.org>, Chen Gang F T
 <chen.gang.flying.transformer@gmail.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
Date: Fri, 22 Mar 2013 19:17:28 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150358CDE5@039-SN1MPN1-002.039d.mgd.msft.net>
References: <51428C81.6000204@asianux.com>
 <25841.1363323174@ale.ozlabs.ibm.com> <5142AE27.7060003@asianux.com>
 <514AA0D9.1090509@asianux.com> <514AC418.1070806@gmail.com>
 <14121.1363908062@ale.ozlabs.ibm.com>
In-Reply-To: <14121.1363908062@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "matt@ozlabs.org" <matt@ozlabs.org>, Chen Gang <gang.chen@asianux.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "imunsie@au1.ibm.com" <imunsie@au1.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBOZXVsaW5n
IFttYWlsdG86bWlrZXlAbmV1bGluZy5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMSwg
MjAxMyA2OjIxIFBNDQo+IFRvOiBDaGVuIEdhbmcgRiBUOyBZb2RlciBTdHVhcnQtQjA4MjQ4OyBL
dW1hciBHYWxhDQo+IENjOiBDaGVuIEdhbmc7IEJlbmphbWluIEhlcnJlbnNjaG1pZHQ7IHNmckBj
YW5iLmF1dWcub3JnLmF1OyBwYXVsdXNAc2FtYmEub3JnOyBtYXR0QG96bGFicy5vcmc7DQo+IGlt
dW5zaWVAYXUxLmlibS5jb207IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbU3VnZ2VzdGlvbl0gUG93ZXJQ
Qzoga2VybmVsOiBjcm9zcyBjb21waWxpbmcgaXNzdWUgd2l0aCBhbGxtb2Rjb25maWcNCj4gDQo+
IENoZW4gR2FuZyBGIFQgPGNoZW4uZ2FuZy5mbHlpbmcudHJhbnNmb3JtZXJAZ21haWwuY29tPiB3
cm90ZToNCj4gDQo+ID4NCj4gPiAgIGl0IHNlZW1zOg0KPiA+ICAgICBvbmx5IG1vdmUgc2xiX21p
c3NfcmVhbG1vZGUgdG8gdGhlIGVuZCwgY2FuIGZpeCB0aGlzIGlzc3VlIHdpdGhvdXQgbmVnYXRp
dmUgZWZmZWN0Lg0KPiANCj4gU28gdGhpcyB3b3JrcyBidXQgdW5jb3ZlcnMgYSBuZXcgYnVnLg0K
PiANCj4gU3R1YXJ0OiBpZiB5b3UgYXBwbHkgdGhpcyBwYXRjaCBhbGxtb2Rjb25maWcgbm93IGdl
dHMgdGhpcyBidWlsZCBlcnJvcg0KPiBvbiBsaW51eC1uZXh0Lg0KPiANCj4gYXJjaC9wb3dlcnBj
L2tlcm5lbC9idWlsdC1pbi5vOiBJbiBmdW5jdGlvbiBgcmVzdG9yZV9wYmxpc3RfcHRyJzoNCj4g
ZnRyYWNlLmM6KC50b2MrMHhkNzgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBlcGFwcl9ldl9p
ZGxlX3N0YXJ0Jw0KPiBmdHJhY2UuYzooLnRvYysweGQ4OCk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYGVwYXByX2V2X2lkbGUnDQo+IG1ha2VbMV06ICoqKiBbdm1saW51eF0gRXJyb3IgMQ0KPiAN
Cj4gUmV2ZXJ0aW5nIHlvdXIgcGF0Y2ggYmVsb3cgZml4ZXMgdGhpczoNCj4gDQo+ICAgY29tbWl0
IGYwNzA5ODZhMDdlNTE0ZTNiNGZjNGFlZjY1NTFiOGRmZmNiMTkyODcNCj4gICBBdXRob3I6IFN0
dWFydCBZb2RlciA8c3R1YXJ0LnlvZGVyQGZyZWVzY2FsZS5jb20+DQo+ICAgRGF0ZTogICBGcmkg
RmViIDggMTM6MjI6NTYgMjAxMyAtMDYwMA0KPiANCj4gICBwb3dlcnBjOiBBZGQgcGFyYXZpcnQg
aWRsZSBsb29wIGZvciA2NC1iaXQgQm9vay1FDQo+IA0KPiAgIFNpZ25lZC1vZmYtYnk6IFN0dWFy
dCBZb2RlciA8c3R1YXJ0LnlvZGVyQGZyZWVzY2FsZS5jb20+DQo+ICAgU2lnbmVkLW9mZi1ieTog
S3VtYXIgR2FsYSA8Z2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gDQo+IFNob3VsZCB3ZSBy
ZXZlcnQgeW91ciBwYXRjaCBvciBjYW4geW91IHNlbmQgYSBmaXg/ICBUaGlzIGlzIGN1cnJlbnRs
eQ0KPiBicm9rZW4gaW4gbGludXgtbmV4dCAoYXQgbGVhc3QgbmV4dC0yMDEzMDMyMSkuDQoNClNl
bnQgYSBwYXRjaCB0aGF0IHJlc29sdmVzIHRoaXMuICBOb3QgY29tcGxldGVseSBoYXBweSB3aXRo
IGl0DQpiZWNhdXNlIG9mIHRoZSBhZGRlZCAjaWZkZWZzLCBidXQgbm90IHN1cmUgaG93IGVsc2Ug
dG8gcmVzb2x2ZQ0KdGhpcy4gICBhbGxtb2Rjb25maWcgaXMgY3JlYXRpbmcgY29uZmlnIGNvbWJp
bmF0aW9ucyB0aGF0IGRvbid0DQpoYXBwZW4gaW4gYSBub3JtYWwgYnVpbGQgKGF0IGxlYXN0IGN1
cnJlbnRseSktLSA2NC1iaXQgYnVpbGQNCnRoYXQgZW5hYmxlcyBFUEFQUl9QQVJBVklSVCBidXQg
bm90IFBQQ19CT09LM0VfNjQuDQoNClN0dWFydA0K
