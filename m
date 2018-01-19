Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0057.outbound.protection.outlook.com [104.47.34.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNMTW4DWszF0yK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 00:42:54 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
 <madalin.bucur@nxp.com>, "madskateman@gmail.com" <madskateman@gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Date: Fri, 19 Jan 2018 13:42:49 +0000
Message-ID: <1516369365.4730.27.camel@infinera.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com> <20180119132251.GJ32299@lunn.ch>
In-Reply-To: <20180119132251.GJ32299@lunn.ch>
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

T24gVGh1LCAxOTcwLTAxLTAxIGF0IDAwOjAwICswMDAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0K
PiANCj4gPiA+IGNvbW1pdCA0ZDhlZTE5MzViY2Q2NjYzNjAzMTFkZmRhZGVlZTIzNWQ2ODJkNjlh
DQo+ID4gPiBBdXRob3I6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0K
PiA+ID4gRGF0ZTogVHVlIEF1ZyAyMiAxNToyNDo0NyAyMDE3IC0wNzAwDQo+ID4gPiBmc2wvbWFu
OiBJbmhlcml0IHBhcmVudCBkZXZpY2UgYW5kIG9mX25vZGUNCj4gPiA+IA0KPiA+ID4gYW5kIHdh
cyBsYXRlciBhZGRyZXNzZWQgYnkgdGhpcyBwYXRjaCBzZXQ6DQo+ID4gPiANCj4gPiA+IGh0dHA6
Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9saXN0Lz9zZXJpZXM9ODQ2MiZz
dGF0ZT0qDQo+ID4gPiANCj4gPiA+IEV2ZW4gd2l0aCB0aGVzZSBlcnJvcnMgcHJpbnRlZCwgYWxs
IGlzIHdvcmtpbmcgZmluZSwgaXQncyBqdXN0IHRoZQ0KPiA+ID4gc2Vjb25kIHByb2JpbmcgdGhh
dCBmYWlscy4gQWRkaW5nIHRoZSBsYXR0ZXIgcGF0Y2hlcyBvciByZXZlcnRpbmcNCj4gPiA+IHRo
ZSBvbmUgYWJvdmUgbWFrZXMgdGhlIGVycm9ycyBwcmludHMgZGlzc2FwZWFyLg0KPiA+IA0KPiA+
IExvb2tpbmcgYXQgdGhlIGFib3ZlIHBhdGNoIHNlcmllcnMgSSBzZWUgaXQgaXMgaW4gc3RhdGUg
QWNjZXB0ZWQgYW5kIGhhcyBiZWVuIHRoZXJlDQo+ID4gc2luY2UgMjAxNy0xMC0xNg0KPiA+IFRo
YXQgc2VlbXMgbGlrZSBhIGF3ZnVsIGxvbmcgdG8gd2FpdCBpbiBiZWZvcmUgZ2V0dGluZyBpbnRv
IExpbnV4LCBpcyB0aGVyZSBzb21ldGhpbmcNCj4gPiBob2xkaW5nIHRoZXNlIHBhdGNoZXMgYmFj
ayA/DQo+IA0KPiBUaGV5IGFyZSBpbiBMaW51eCwgaGF2ZSBiZWVuIHNpbmNlIE9jdG9iZXIgMTZ0
aC4gQnV0IGF0IHRoZSBtb21lbnQsDQo+IHRoZXkgYXJlIG9ubHkgaW4gdjQuMTUsIG5vdCB2NC4x
NC4NCg0KTm93IEkgc2VlIHRoZW0gaW4gNC4xNSwgbXVzdCBoYXZlIGxvb2tlZCBpbiB0aGUgd3Jv
bmcgYnJhbmNoLg0KDQo+IA0KPiBUaGVzZSBwYXRjaGVzIHByb2JhYmx5IGRvbid0IGZpdCB0aGUg
c3RhYmxlIHJ1bGVzLCBmb3IgZ2V0dGluZyB0aGVtDQo+IGFkZGVkIHRvIHY0LjE0Lg0KPiANCj4g
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRp
b24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLnJzdA0KDQpTdHVmZiBuZWVkcyB0byB3b3Jr
LCB3aGF0ZXZlciBuZWVkZWQgdG8gbWFrZSB0aGF0IGhhcHBlbiBpcyBhbGxvd2VkLiBFdmVuIGJh
Y2twb3J0aW5nDQpzb21lIG5ldyBpbmZyYSBzdHJ1Y3R1cmUgaWYgbmVlZCBiZSB0byBzaW1wbGlm
eSBmaXhpbmcgYnVncy4NCg0KPiANCj4gV2hhdCBpcyBuZWVkZWQgaXMgYSBtaW5pbWFsIGZpeC4g
T3IganVzdCB3YWl0IHVudGlsIFN1bmRheSwgd2hlbiB0aGVyZQ0KPiBpcyBhIGdvb2QgY2hhbmNl
IHY0LjE1IHdpbGwgYmUgcmVsZWFzZWQuDQoNCllvdSBzZWVtIHRvIHRoaW5rIGV2ZXJ5b25lIGFs
d2F5cyB1cGdyYWRlIHRvIGxpbnV4IGxhdGVzdCBidXQgdGhpcyBpcyBub3Qgc28uDQpXZSBkbyBw
cm9kdWN0IGRldmVsb3BtZW50IGhlcmUgYW5kIGFwcHJlY2lhdGUgdGhlIHN0YWJsZSBrZXJuZWxz
IHNvIHdlIGNhbiB3b3JrIGluDQpwZWFjZSBhbmQgbm90IGNoYXNpbmcgdGhlIGxhdGVzdCBrZXJu
ZWwuDQoNCiBKb2NrZQ==
