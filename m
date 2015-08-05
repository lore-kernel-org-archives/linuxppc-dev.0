Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F04B91A031C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 14:34:03 +1000 (AEST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [1/2] powerpc/config: enable teranetics PHY
Date: Wed, 5 Aug 2015 03:00:33 +0000
Message-ID: <BLUPR03MB147568BDE5BECB525F21EDE3E2750@BLUPR03MB1475.namprd03.prod.outlook.com>
References: <1437709533-26452-1-git-send-email-shh.xie@gmail.com>
 <20150805001848.GA2861@home.buserror.net>
 <1438734294.2097.102.camel@freescale.com>
 <1438734404.2097.104.camel@freescale.com>
In-Reply-To: <1438734404.2097.104.camel@freescale.com>
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

PiBPbiBUdWUsIDIwMTUtMDgtMDQgYXQgMTk6MjQgLTA1MDAsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+
ID4gT24gVHVlLCAyMDE1LTA4LTA0IGF0IDE5OjE4IC0wNTAwLCBTY290dCBXb29kIHdyb3RlOg0K
PiA+ID4gT24gRnJpLCBKdWwgMjQsIDIwMTUgYXQgMTE6NDU6MzNBTSArMDgwMCwgc2hhb2h1aSB4
aWUgd3JvdGU6DQo+ID4gPiA+IEZyb206IFNoYW9odWkgWGllIDxTaGFvaHVpLlhpZUBmcmVlc2Nh
bGUuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgUEhZIHVzZXMgWEFVSSBpbnRlcmZhY2UgdG8g
Y29ubmVjdCB0byBNQUMsIG1vc3RseSB0aGUgUEhZIHVzZWQNCj4gPiA+ID4gb24gcmlzZXIgY2Fy
ZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hhb2h1aSBYaWUgPFNoYW9odWku
WGllQGZyZWVzY2FsZS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC9wb3dlcnBjL2Nv
bmZpZ3MvY29yZW5ldDMyX3NtcF9kZWZjb25maWcgfCAxICsNCj4gPiA+ID4gYXJjaC9wb3dlcnBj
L2NvbmZpZ3MvY29yZW5ldDY0X3NtcF9kZWZjb25maWcgfCAxICsNCj4gPiA+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gTmV4dCB0aW1lLCBwbGVhc2Ug
dXNlIGEgc3ViamVjdCBsaW5lIHRoYXQgbGV0cyBtZSBrbm93IHRoYXQgdGhpcyBpcw0KPiA+ID4g
YSBwYXRjaCB0aGF0IEknZCBiZSBwaWNraW5nIHVwLCBzdWNoIGFzICJwb3dlcnBjLzg1eHg6IC4u
LiIgb3INCj4gPiA+ICJwb3dlcnBjL2NvcmVuZXQ6IC4uLiINCj4gPg0KPiA+IE1vcmUgaW1wb3J0
YW50bHksIGRvbid0IHNlbmQgcGF0Y2hlcyB0byBlbmFibGUgY29uZmlnIG9wdGlvbnMgdGhhdA0K
PiA+IGRvbid0IGV4aXN0Lg0KPiANCj4gU29ycnksIHRoaXMgY29tbWVudCB3YXMgbWVhbnQgZm9y
IHBhdGNoIDIvMiAoQ09ORklHX0FRVUFOVElBX1BIWSkuDQo+IENPTkZJR19URVJBTkVUSUNTX1BI
WSBkb2VzIGV4aXN0IGluIGxpbnV4LW5leHQgKHRoYXQgaXQgZGVwZW5kcyBvbiBhDQo+IHBhdGNo
IGluIGxpbnV4LW5leHQgc2hvdWxkIGJlIG1lbnRpb25lZCBiZWxvdyB0aGUgLS0tKS4NCkhpIFNj
b3R0LA0KDQpUaGUgQ09ORklHX0FRVUFOVElBX1BIWSB3YXMgYWRkZWQgaW4gYW5vdGhlciBwYXRj
aCBzZW50IHRvIG5ldC1uZXh0LCANCml0IHdhcyBub3QgYWNjZXB0ZWQgd2hlbiBJIHNlbnQgdGhl
IHBhdGNoIHRvIGVuYWJsZSB0aGlzIGNvbmZpZywNCmxhdGVyIHRoZSBwYXRjaCB3YXMgYWNjZXB0
ZWQgaW4gbmV0LW5leHQsDQpodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVs
L2dpdC9kYXZlbS9uZXQtbmV4dC5naXQvY29tbWl0Lz9pZD1iZWU4MjU5ZGQzMWY0MTlhODgzMTc0
NTU2YjExZWRjNmY5YTE1M2QxDQoNCkkgc2hvdWxkIG1lbnRpb24gdGhpcyBiZWxvdyB0aGUgLS0t
Lg0KU29ycnkhDQoNClNob3VsZCBJIHJlLXNlbmQgdGhlIHBhdGNoIG9mIGVuYWJsaW5nIGNvbmZp
ZyBvcHRpb24gb2YgQ09ORklHX0FRVUFOVElBX1BIWT8NCg0KVGhhbmtzIQ0KU2hhb2h1aQ0KDQo=
