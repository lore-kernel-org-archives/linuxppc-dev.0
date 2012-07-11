Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71A6C2C0200
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 12:07:13 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on
 core1 of AMP boot issue
Date: Wed, 11 Jul 2012 02:07:04 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A218AA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
 <4FFC7139.3080303@freescale.com>
In-Reply-To: <4FFC7139.3080303@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDExLCAyMDEyIDI6MTUgQU0NCj4gVG86IEppYSBI
b25ndGFvLUIzODk1MQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGdhbGFr
QGtlcm5lbC5jcmFzaGluZy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBvd2VycGMv
bXBjODU3MmRzOiBGaXggZVRTRUMgaXMgbm90IGF2YWlsYWJsZSBvbg0KPiBjb3JlMSBvZiBBTVAg
Ym9vdCBpc3N1ZQ0KPiANCj4gT24gMDcvMTAvMjAxMiAwMTowOCBBTSwgSmlhIEhvbmd0YW8gd3Jv
dGU6DQo+ID4gVGhlIGlzc3VlIGxvZyBvbiBjb3JlMSBpczoNCj4gPiByb290QG1wYzg1NzJkczp+
IyBpZmNvbmZpZyBldGgwIDEwLjE5Mi4yMDguMjQ0DQo+ID4gbmV0IGV0aDA6IGNvdWxkIG5vdCBh
dHRhY2ggdG8gUEhZDQo+ID4gU0lPQ1NJRkZMQUdTOiBObyBzdWNoIGRldmljZQ0KPiA+DQo+ID4g
VG8gYXR0YWNoIFBIWSBub2RlIG1kaW9AMjQ1MjAgc2hvdWxkIG5vdCBiZSBkaXNhYmxlZCBpbiBk
dHMgb2YgY29yZTEuDQo+ID4gQmVjYXVzZSBhbGwgUEhZcyBhcmUgY29udHJvbGxlZCB0aHJvdWdo
IHRoaXMgbm9kZSBhcyBmb2xsb3dzOg0KPiANCj4gU28geW91IGdyYW50IGl0IHRvIGJvdGggcGFy
dGl0aW9ucz8gIEhvdyBkbyB5b3UgZGVhbCB3aXRoIHN5bmNocm9uaXphdGlvbj8NCj4gDQo+IC1T
Y290dA0KDQpQSFkgbm9kZXMgYXJlIG9ubHkgdXNlZCBieSBldGhlcm5ldC4gRWFjaCBldGhlcm5l
dCBpcyB1c2VkIGJ5IG9ubHkgb25lIHBhcnRpdGlvbg0KKGRpc2FibGVkIGluIHRoZSBvdGhlciBw
YXJ0aXRpb24pLiBTbyBJIHRoaW5rIHRoZXJlIGlzIG5vIHN5bmNocm9uaXphdGlvbiBpc3N1ZS4N
Cg0KVGhhbmtzLg0KLUppYSBIb25ndGFvLiANCg==
