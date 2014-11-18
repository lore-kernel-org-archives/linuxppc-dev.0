Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D096F1A065E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 21:33:56 +1100 (AEDT)
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B739B14010B
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 21:33:55 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 11474-05 for <linuxppc-dev@ozlabs.org>;
 Tue, 18 Nov 2014 10:27:05 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] powerpc: Remove more traces of bootmem
Date: Tue, 18 Nov 2014 10:26:34 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9F2964@AcuExch.aculab.com>
References: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
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

RnJvbTogTWljaGFlbCBFbGxlcm1hbg0KPiBBbHRob3VnaCB3ZSBhcmUgbm93IHNlbGVjdGluZyBO
T19CT09UTUVNLCB3ZSBzdGlsbCBoYXZlIHNvbWUgdHJhY2VzIG9mDQo+IGJvb3RtZW0gbHlpbmcg
YXJvdW5kLiBUaGF0IGlzIGJlY2F1c2UgZXZlbiB3aXRoIE5PX0JPT1RNRU0gdGhlcmUgaXMNCj4g
c3RpbGwgYSBzaGltIHRoYXQgY29udmVydHMgYm9vdG1lbSBjYWxscyBpbnRvIG1lbWJsb2NrIGNh
bGxzLCBidXQNCj4gdWx0aW1hdGVseSB3ZSB3YW50IHRvIHJlbW92ZSBhbGwgdHJhY2VzIG9mIGJv
b3RtZW0uDQo+IA0KPiBNb3N0IG9mIHRoZSBwYXRjaCBpcyBjb252ZXJzaW9ucyBmcm9tIGFsbG9j
X2Jvb3RtZW0oKSB0bw0KPiBtZW1ibG9ja19hbGxvYygpLiBJbiBnZW5lcmFsIGEgY2FsbCBzdWNo
IGFzOg0KPiANCj4gICBwID0gKHN0cnVjdCBmb28gKilhbGxvY19ib290bWVtKHgpOw0KPiANCj4g
QmVjb21lczoNCj4gDQo+ICAgcCA9IF9fdmEobWVtYmxvY2tfYWxsb2MoeCwgMCkpOw0KPiANCj4g
V2UgbmVlZCBfX3ZhKCkgYmVjYXVzZSBtZW1ibG9jayByZXR1cm5zIGEgcGh5c2ljYWwgYWRkcmVz
cy4gV2UgZG9uJ3QNCj4gbmVlZCB0aGUgY2FzdCBiZWNhdXNlIF9fdmEoKSByZXR1cm5zIGEgdm9p
ZCAqLiBUaGUgYWxpZ25tZW50IHZhbHVlIG9mDQo+IHplcm8gdGVsbHMgbWVtYmxvY2sgdG8gdXNl
IHRoZSBkZWZhdWx0IGFsaWdubWVudCwgd2hpY2ggaXMNCj4gU01QX0NBQ0hFX0JZVEVTLCB0aGUg
c2FtZSB2YWx1ZSBhbGxvY19ib290bWVtKCkgdXNlcy4NCg0KSXQgZG9lc24ndCBzZWVtIHJpZ2h0
IHRvIG1lIHRvIHJlcGxpY2F0ZSBfX3ZhKG1lbWJsb2NrX2FsbG9jKHgsIDApKQ0KdGhhdCBtYW55
IHRpbWVzLiBJIGNhbiBpbWFnaW5lIHRoYXQgdGhlIHJlcXVpcmVkIGNvZGUgd2lsbCBjaGFuZ2UN
CmFnYWluIGF0IHRvIGZ1dHVyZSB0aW1lLCBhbmQgdGhlbiBhbGwgdGhlIHNhbWUgcGxhY2VzIHdv
dWxkIG5lZWQgY2hhbmdpbmcuDQoNCldvdWxkbid0IGl0IGJlIGJldHRlciB0byB1c2U6DQojZGVm
aW5lIGFsbG9jX2Jvb3RtZW0oeCkgX192YShtZW1ibG9ja19hbGxvYyh4LCAwKSkNCnBvc3NpYmx5
IHdpdGggYSByZW5hbWUsIG9yIGFzIGEgc3RhdGljIGlubGluZS4NCklmIF9fdmEoKSBpcyBub24t
dHJpdmlhbCB5b3Ugd2FudCBhIHJlYWwgZnVuY3Rpb24uDQoNCglEYXZpZA0KDQo=
