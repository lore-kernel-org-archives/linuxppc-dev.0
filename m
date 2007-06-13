Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8B0D6DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 19:10:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 05/30] PS3: Use ioremap_flags
Date: Wed, 13 Jun 2007 11:10:48 +0200
References: <20070612181825.730300780@am.sony.com>
	<20070612181825.730300780@am.sony.com>> <466EE965.404@am.sony.com>
In-Reply-To: <466EE965.404@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706131110.48809.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVHVlc2RheSAxMiBKdW5lIDIwMDcsIEdlb2ZmIExldmFuZCB3cm90ZToKPiAtwqDCoMKgwqDC
oMKgwqBzcHUtPnByb2JsZW0gPSBpb3JlbWFwKHNwdS0+cHJvYmxlbV9waHlzLAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaXplb2Yoc3RydWN0IHNwdV9wcm9ibGVtKSk7Cj4gK8Kg
wqDCoMKgwqDCoMKgc3B1LT5wcm9ibGVtID0gKF9fZm9yY2Ugdm9pZCAqKWlvcmVtYXBfZmxhZ3Mo
c3B1LT5wcm9ibGVtX3BoeXMsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemVv
ZihzdHJ1Y3Qgc3B1X3Byb2JsZW0pLCBfUEFHRV9OT19DQUNIRSk7Cj4gKwoKVW5saWtlIHRoZSBs
b2NhbF9zdG9yZSBtZW1iZXIsIG9mIHN0cnVjdCBzcHUsIC0+cHJvYmxlbSBhbmQgLT5wcml2Mgpt
ZW1iZXJzIGFyZSBfX2lvbWVtLCBzbyB5b3Ugc2hvdWxkIG5vdCBkbyBhIF9fZm9yY2UgY2FzdCBo
ZXJlLgoKT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0Y2ggbG9va3MgZ29vZC4KCk5vdGUgdGhhdCBJ
IG1heSByZXBseSBmYXN0ZXIgaXMgeW91IHNlbmQgeW91ciBtZXNzYWdlcyB0byBhcm5kQGFybmRi
LmRlCmluc3RlYWQgb2YgYXJuZC5iZXJnbWFubkBkZS5pYm0uY29tLgoKCUFybmQgPD48Cg==
