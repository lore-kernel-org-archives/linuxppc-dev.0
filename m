Return-Path: <r66093@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22CA32C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2012 12:40:28 +1100 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: RE: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Mon, 29 Oct 2012 01:40:19 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1E9664@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
 <20121025103038.GA5107@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121027011249.GB9152@lizard>
In-Reply-To: <20121027011249.GB9152@lizard>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Chris Ball <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBIZWxsbyBIdWFuZywNCj4gDQo+IE9uIEZyaSwgT2N0IDI2LCAyMDEyIGF0IDAyOjQyOjM2QU0g
KzAwMDAsIEh1YW5nIENoYW5nbWluZy1SNjYwOTMgd3JvdGU6DQo+ID4gRm9yIHRoZSBjdXJyZW50
IHBvbGxpbmcgbW9kZSwgZHJpdmVyIHdpbGwgc2VuZCBDTUQxMyB0byBwb2xsIHRoZSBjYXJkDQo+
IHN0YXR1cyBwZXJpb2RpY2FsbHkgLCB3aGljaCB3aWxsIGNhdXNlIHRvbyBtYW55IGludGVycnVw
dHMuDQo+ID4gT25jZSBJIHNlbnQgcGF0Y2hlcyB0byBkZXRlY3QgdGhlIGNhcmQgd2hlbiB1c2lu
ZyBwb2xsaW5nIG1vZGUgbGFzdA0KPiB5ZWFyOiByZWFkIHRoZSBzdGF0ZSByZWdpc3RlciwgaW5z
dGVhZCBvZiBzZW5kIENNRDEzLiBCdXQsIHRoZXNlIHBhdGNoZXMNCj4gd2VyZSBub3QgYWNjZXB0
ZWQuIE5vdyBJIGF0dGFjaCB0aGVtIGZvciB5b3UuDQo+IA0KPiBXYXMgdGhlcmUgYW55IHNwZWNp
ZmljIHJlYXNvbiB3aHkgdGhlIHBhdGNoZXMgZGlkbid0IGdldCBhY2NlcHRlZD8NCj4gDQo+IEkg
dmVyeSBicmllZmx5IGxvb2tlZCBhdCB0aGVtLCBhbmQgdGhleSBzZWVtIHRvIGJlIE9LICh0aGVy
ZSBhcmUgYSBmZXcNCj4gY29zbWV0aWMgZGV0YWlscyBJJ2QgY29tbWVudCBvbiwgdGhvIC0tIGJ1
dCBwbGVhc2Ugc2VuZCB0aGVtIGluIGEgbm9ybWFsDQo+IHdheSAoaS5lLiBub3QgYXMgYXR0YWNo
bWVudHMpLg0KPiANCg0KVGhhbmtzLCBBbnRvbi4NCkkgZG9uJ3Qga25vdyB3aHkuDQpJIHdpbGwg
cmVzZW5kIHRoZXNlIHBhdGNoZXMgYmFzZWQgb24gbGF0ZXN0IGtlcm5lbC4NCg0K
