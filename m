Return-Path: <B29983@freescale.com>
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
Date: Wed, 17 Apr 2013 02:44:27 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B1456B8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAOZdJXW8qKccGKic3R4o1aqJdbfHcBoAp62B4HPFnF=sUAEvuQ@mail.gmail.com>
In-Reply-To: <CAOZdJXW8qKccGKic3R4o1aqJdbfHcBoAp62B4HPFnF=sUAEvuQ@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11ciBUYWJpIFttYWlsdG86
dGltdXJAdGFiaS5vcmddDQo+IFNlbnQ6IDIwMTPE6jTUwjE2yNUgMTk6MzcNCj4gVG86IFRhbmcg
WXVhbnRpYW4tQjI5OTgzDQo+IENjOiBHcmFudCBMaWtlbHk7IGRldmljZXRyZWUtZGlzY3Vzczsg
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxrbWw7DQo+IFJvYiBIZXJyaW5nDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG9mL2Jhc2U6IHJlbGVhc2UgdGhlIG5vZGUgY29ycmVjdGx5
IGluDQo+IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKCkNCj4gDQo+IE9uIFR1ZSwgQXByIDks
IDIwMTMgYXQgMTA6MzYgUE0sICA8WXVhbnRpYW4uVGFuZ0BmcmVlc2NhbGUuY29tPiB3cm90ZToN
Cj4gPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIEZvdW5kIGl0ISByZXR1cm4gc3Vj
Y2VzcyAqLw0KPiANCj4gSSdtIHByZXR0eSBzdXJlIHRoaXMgY29tbWVudCBpcyBpbiB0aGUgd3Jv
bmcgcGxhY2UuDQoNCkl0IGlzIG5vdCBwZXJmZWN0LCBidXQgYWNjZXB0YWJsZS4NCg0KLVl1YW50
aWFuDQoNCg==
