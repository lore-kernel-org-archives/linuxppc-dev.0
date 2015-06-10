Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52BD91A0F56
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 19:12:48 +1000 (AEST)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "edubezval@gmail.com" <edubezval@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>
Subject: RE: [PATCH V2] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
Date: Wed, 10 Jun 2015 08:56:55 +0000
Message-ID: <BLUPR03MB1499AA1359894C6B1F801FCE1BD0@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1429085868-47577-1-git-send-email-hongtao.jia@freescale.com>
 <BLUPR03MB1498C018F80A754767DF48FE1CC0@BLUPR03MB149.namprd03.prod.outlook.com>
 <1432669078.7862.13.camel@freescale.com>
 <BLUPR03MB149DC0A753423EB27293931E1BE0@BLUPR03MB149.namprd03.prod.outlook.com>
 <1433872049.2477.80.camel@freescale.com>
In-Reply-To: <1433872049.2477.80.camel@freescale.com>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAxNSAxOjQ3IEFNDQo+IFRvOiBKaWEgSG9u
Z3Rhby1CMzg5NTENCj4gQ2M6IGVkdWJlenZhbEBnbWFpbC5jb207IGxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBydWkuemhhbmdAaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIFFv
cklRL1RNVTogYWRkIFRNVSBub2RlIHRvIGRldmljZSB0cmVlIGZvciBRb3JJUQ0KPiBUMTA0eA0K
PiANCj4gT24gTW9uLCAyMDE1LTA2LTA4IGF0IDIxOjE5IC0wNTAwLCBKaWEgSG9uZ3Rhby1CMzg5
NTEgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
V29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDE1IDM6
MzggQU0NCj4gPiA+IFRvOiBKaWEgSG9uZ3Rhby1CMzg5NTENCj4gPiA+IENjOiBlZHViZXp2YWxA
Z21haWwuY29tOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gPiA+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5j
b20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIFFvcklRL1RNVTogYWRkIFRNVSBub2Rl
IHRvIGRldmljZSB0cmVlIGZvcg0KPiA+ID4gUW9ySVEgVDEwNHgNCj4gPiA+DQo+ID4gPiBPbiBU
dWUsIDIwMTUtMDUtMjYgYXQgMDE6MzMgLTA1MDAsIEppYSBIb25ndGFvLUIzODk1MSB3cm90ZToN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDEwNDBzaS1w
b3N0LmR0c2kNCj4gPiA+ID4gPiBiL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDEwNDBzaS1w
b3N0LmR0c2kNCj4gPiA+ID4gPiBpbmRleCAxNWFlNDYyLi5iYjlmNzkyIDEwMDY0NA0KPiA+ID4g
PiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDEwNDBzaS1wb3N0LmR0c2kNCj4g
PiA+ID4gPiArKysgYi9hcmNoL3Bvd2VycGMvYm9vdC9kdHMvZnNsL3QxMDQwc2ktcG9zdC5kdHNp
DQo+ID4gPiA+ID4gQEAgLTM0NSw2ICszNDUsNyBAQA0KPiA+ID4gPiA+ICAgICAgICAgICAgIHJl
ZyAgICAgICAgPSA8MHhlYTAwMCAweDQwMDA+Ow0KPiA+ID4gPiA+ICAgICB9Ow0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gKy9pbmNsdWRlLyAicW9yaXEtdG11LXQxMDR4c2kuZHRzaSINCj4gPiA+ID4g
PiAgL2luY2x1ZGUvICJlbG8zLWRtYS0wLmR0c2kiDQo+ID4gPiA+ID4gIC9pbmNsdWRlLyAiZWxv
My1kbWEtMS5kdHNpIg0KPiA+ID4gPiA+ICAvaW5jbHVkZS8gInFvcmlxLWVzcGktMC5kdHNpIg0K
PiA+ID4NCj4gPiA+IFdoeSBpcyB0aGlzIGNoaXAtc3BlY2lmaWMgZW5vdWdoIHRvIGJlIGNhbGxl
ZCAidDEwNHhzaSIsIGJ1dCBub3QNCj4gPiA+IGNoaXAtDQo+ID4gPiBzcGVjaWZpYyBlbm91Z2gg
dG8ganVzdCBnbyBkaXJlY3RseSBpbnRvIHQxMDQwc2ktcG9zdD8NCg0KVGhlIHRtdSBub2RlIGlu
Y2x1ZGVzIGxvdHMgb2YgY29udGVudHMuDQpJcyBpdCBsb29rcyBtZXNzeSBpZiBqdXN0IGdvIGRp
cmVjdGx5IGludG8gdDEwNDBzaS1wb3N0Pw0KDQo+ID4NCj4gPiBUMTA0eCBwbGF0Zm9ybSBzaGFy
ZSB0aGUgc2FtZSBjYWxpYnJhdGlvbiBkYXRhLg0KPiANCj4gV2hpY2ggdDEwNHggYXJlIHlvdSBy
ZWZlcnJpbmcgdG8gdGhhdCBkb2Vzbid0IHVzZSB0MTA0MHNpLXBvc3QuZHRzaT8NCj4gUGx1cywg
Z2l2ZW4gdGhlIG51bWJlcmluZyBzY2hlbWUgaXQncyBhbHdheXMgcG9zc2libGUgdGhhdCBhIG5l
dyB0MTA0eA0KPiBjb21lcyBvdXQgdGhhdCBoYXMgbGl0dGxlIHRvIGRvIHdpdGggZXhpc3Rpbmcg
dDEwNHguDQoNClllcywgcmlnaHQuIFRoZSBuYW1lIGNvbnRhaW5zICJ0MTA0eCIga2V5d29yZCBz
ZWVtcyBub3QgcGVyZmVjdC4NCkknZCBsaWtlIHRvIGNoYW5nZSAicW9yaXEtdG11LXQxMDR4c2ku
ZHRzaSIgdG8gInFvcmlxLXRtdS10MTA0MHNpLmR0c2kiDQphbmQgaW5jbHVkZWQgaW4gdDEwNDBz
aS1wb3N0LiBJcyB0aGlzIE9LIHdpdGggeW91Pw0KDQotSG9uZ3Rhby4NCg0KPiANCj4gLVNjb3R0
DQo+IA0KDQo=
