Return-Path: <Motohiro.Kosaki@us.fujitsu.com>
Received: from fujitsu24.fnanic.fujitsu.com (fujitsu24.fnanic.fujitsu.com
 [192.240.6.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E3EAB140F97
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 03:05:10 +1000 (EST)
From: Motohiro Kosaki <Motohiro.Kosaki@us.fujitsu.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 5 May 2014 09:29:31 -0700
Subject: RE: [PATCH] powerpc: Fix comment around arch specific definition of
 RECLAIM_DISTANCE
Message-ID: <6B2BA408B38BA1478B473C31C3D2074E31D516BB87@SV-EXCHANGE1.Corp.FC.LOCAL>
References: <20140505051713.7744.47492.stgit@preeti>
In-Reply-To: <20140505051713.7744.47492.stgit@preeti>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "anton@samba.org" <anton@samba.org>,
 Motohiro Kosaki JP <kosaki.motohiro@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQcmVldGkgVSBNdXJ0aHkgW21h
aWx0bzpwcmVldGlAbGludXgudm5ldC5pYm0uY29tXQ0KPiBTZW50OiBNb25kYXksIE1heSAwNSwg
MjAxNCAxOjE3IEFNDQo+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBDYzog
YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBhbnRvbkBzYW1iYS5vcmc7IE1vdG9oaXJvIEtvc2Fr
aSBKUA0KPiBTdWJqZWN0OiBbUEFUQ0hdIHBvd2VycGM6IEZpeCBjb21tZW50IGFyb3VuZCBhcmNo
IHNwZWNpZmljIGRlZmluaXRpb24gb2YgUkVDTEFJTV9ESVNUQU5DRQ0KPiANCj4gQ29tbWl0IDMy
ZTQ1ZmY0M2VhZjVjMTdmIGNoYW5nZWQgdGhlIGRlZmF1bHQgdmFsdWUgb2YgUkVDTEFJTV9ESVNU
QU5DRSB0byAzMC4gSG93ZXZlciB0aGUgY29tbWVudCBhcm91bmQgYXJjaCBzcGVjaWZjDQo+IGRl
ZmluaXRpb24gb2YgUkVDTEFJTV9ESVNUQU5DRSBpcyBub3QgdXBkYXRlZCB0byByZWZsZWN0IHRo
ZSBzYW1lLiBDb3JyZWN0IHRoZSB2YWx1ZSBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQcmVldGkgVSBNdXJ0aHkgPHByZWV0aUBsaW51eC52bmV0LmlibS5j
b20+DQo+IENjOiBBbnRvbiBCbGFuY2hhcmQgPGFudG9uQHNhbWJhLm9yZz4NCj4gQ2M6IEJlbmph
bWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gQ2M6IEtPU0FL
SSBNb3RvaGlybyA8a29zYWtpLm1vdG9oaXJvQGpwLmZ1aml0c3UuY29tPg0KDQpBY2tlZC1ieTog
S09TQUtJIE1vdG9oaXJvIDxLb3Nha2kubW90b2hpcm9AanAuZnVqaXRzdS5jb20+DQoNCg==
