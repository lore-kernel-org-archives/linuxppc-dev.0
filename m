Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC63D1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 20:42:28 +1100 (AEDT)
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B2C5141415
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2015 20:42:28 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>
Subject: RE: [PATCH] of: Print rather than WARN'ing when overlap check fails
Date: Tue, 10 Nov 2015 09:41:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBCEE2E@AcuExch.aculab.com>
References: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogTWljaGFlbCBFbGxlcm1hbg0KPiBTZW50OiAxMCBOb3ZlbWJlciAyMDE1IDA1OjA5DQo+
IF9fcm1lbV9jaGVja19mb3Jfb3ZlcmxhcCgpIGlzIGNhbGxlZCB2ZXJ5IGVhcmx5IGluIGJvb3Qs
IGFuZCBvbiBzb21lDQo+IHBvd2VycGMgc3lzdGVtcyBpdCdzIG5vdCBzYWZlIHRvIGNhbGwgV0FS
TiB0aGF0IGVhcmx5IGluIGJvb3QuDQo+IA0KPiBJZiB0aGUgb3ZlcmxhcCBjaGVjayBmYWlscyB0
aGUgc3lzdGVtIHdpbGwgb29wcyBpbnN0ZWFkIG9mIHByaW50aW5nIGENCj4gd2FybmluZy4gRnVy
dGhlcm1vcmUgYmVjYXVzZSBpdCdzIHNvIGVhcmx5IGluIGJvb3QgdGhlIGNvbnNvbGUgaXMgbm90
IHVwDQo+IGFuZCB0aGUgdXNlciBkb2Vzbid0IHNlZSB0aGUgb29wcywgdGhleSBqdXN0IGdldCBh
IGRlYWQgc3lzdGVtLg0KDQpXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gYWRkIHRoZSByZXF1aXJl
ZCBjaGVja3MgdG8gV0FSTigpPw0KVGhhdCB3b3VsZCBzdG9wIHRoZSBzYW1lIHByb2JsZW0gaGFw
cGVuaW5nIGVsc2V3aGVyZS4NCg0KCURhdmlkDQoNCg==
