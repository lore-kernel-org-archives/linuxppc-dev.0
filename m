Return-Path: <B29983@freescale.com>
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
Date: Wed, 17 Apr 2013 04:49:20 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B1457D2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAOZdJXW8qKccGKic3R4o1aqJdbfHcBoAp62B4HPFnF=sUAEvuQ@mail.gmail.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B1456B8@039-SN2MPN1-013.039d.mgd.msft.net>
 <516E1763.7040206@tabi.org>
In-Reply-To: <516E1763.7040206@tabi.org>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltdXIgVGFiaSBbbWFp
bHRvOnRpbXVyQHRhYmkub3JnXQ0KPiBTZW50OiAyMDEzxOo01MIxN8jVIDExOjMxDQo+IFRvOiBU
YW5nIFl1YW50aWFuLUIyOTk4Mw0KPiBDYzogR3JhbnQgTGlrZWx5OyBkZXZpY2V0cmVlLWRpc2N1
c3M7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsa21sOw0KPiBSb2IgSGVycmluZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBvZi9iYXNlOiByZWxlYXNlIHRoZSBub2RlIGNvcnJl
Y3RseSBpbg0KPiBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncygpDQo+IA0KPiBUYW5nIFl1YW50
aWFuLUIyOTk4MyB3cm90ZToNCj4gPj4gPk9uIFR1ZSwgQXByIDksIDIwMTMgYXQgMTA6MzYgUE0s
PFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4gIHdyb3RlOg0KPiA+Pj4gPiA+DQo+ID4+PiA+
ID4rICAgICAgICAgICAgICAgICAgICAgICAvKiBGb3VuZCBpdCEgcmV0dXJuIHN1Y2Nlc3MgKi8N
Cj4gPj4gPg0KPiA+PiA+SSdtIHByZXR0eSBzdXJlIHRoaXMgY29tbWVudCBpcyBpbiB0aGUgd3Jv
bmcgcGxhY2UuDQo+IA0KPiA+IEl0IGlzIG5vdCBwZXJmZWN0LCBidXQgYWNjZXB0YWJsZS4NCj4g
DQo+IExpa2UgSSBzYWlkLCBJJ20gcHJldHR5IHN1cmUgaXQncyBpbiB0aGUgd3JvbmcgcGxhY2Uu
DQo+IA0KDQpJdCB3YXMgcGxhY2VkIG9uIEVMU0Ugc3RhdGVtZW50IG9yaWdpbmFsbHksIEkgbW92
ZWQgaXQgdG8gSUYgc3RhdGVtZW50Lg0KV2h5IGlzIGl0IHNvIHdyb25nPw0KDQpUaGFua3MsDQpZ
dWFudGlhbg0K
