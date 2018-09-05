Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4255CR0v6VzF35K
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 00:08:26 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Scott Wood <oss@buserror.net>, Christian Zigotzky
 <chzigotzky@xenosoft.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: FSL/NXP P5020: USB problems with the latest Git kernels
Date: Wed, 5 Sep 2018 14:08:21 +0000
Message-ID: <AM6PR0402MB38644F9691306961BBD68C0DEC020@AM6PR0402MB3864.eurprd04.prod.outlook.com>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
 <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
 <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
 <07ad630cccbd33c81031f690fd17cdc30b662e49.camel@buserror.net>
In-Reply-To: <07ad630cccbd33c81031f690fd17cdc30b662e49.camel@buserror.net>
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

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0gDQo+IE9uIE1vbiwgMjAx
OC0wOC0yNyBhdCAyMDoxNSArMDIwMCwgQ2hyaXN0aWFuIFppZ290emt5IHdyb3RlOg0KPiA+IEhl
bGxvLA0KPiA+DQo+ID4gT3VyIHVzZXJzIHRlc3RlZCB0aGUgUkMxIG9mIGtlcm5lbCA0LjE5IG9u
IHRoZWlyIFA1MDIwIGJvYXJkcyB0b2RheS4NCj4gPiBVbmZvcnR1bmF0ZWx5IHRoZSBVU0IgYnVn
IHN0aWxsIGV4aXN0cy4gV2l0aCBtZW0gdmFsdWVzIGJpZ2dlciB0aGFuDQo+IDQwOTZNLA0KPiA+
IHRoZSBVU0IgbW91c2UgYW5kIGtleWJvYXJkIGRvZXNu4oCZdCB3b3JrLiBXaXRoIHRoZSBib290
YXJnIG1lbT00MDk2TSwgdGhlDQo+IFVTQg0KPiA+IGRldmljZXMgd29yayB3aXRob3V0IGFueSBw
cm9ibGVtcy4gUGxlYXNlIGNvbXBpbGUgdGhlIFJDMSBhbmQgdGVzdCBpdCBvbg0KPiA+IHlvdXIg
UDUwMjAgYm9hcmQuIFRoZXJlIGlzIGEgcHJvYmxlbSB3aXRoIHRoZSBtZW1vcnkgbWFuYWdlbWVu
dCBzaW5jZQ0KPiA+IDIyLzA4LzE4Lg0KPiANCj4gSSBqdXN0IHRlc3RlZCA0LjE5LXJjMSBvbiBh
IFQ0MjQwIGFuZCBnb3QgYSBzaW1pbGFyIHByb2JsZW0gd2l0aCBNTUMuICBNTUMNCj4gYW5kDQo+
IFVTQiBvbiB0aGVzZSBjaGlwcyBib3RoIGhhdmUgYSAzMi1iaXQgRE1BIGxpbWl0YXRpb24uICBJ
J2xsIGxvb2sgaW50byBpdC4NCg0KSSBlbmNvdW50ZXJlZCBzaW1pbGFyIGlzc3VlcyBvbiBMUzEw
NHhBIGNoaXBzLiBUaGlzIGlzIHRoZSB3b3JrYXJvdW5kIGZvciBNTUM6DQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzEwNTA2NjI3Lw0KT24gdGhlIFVTQiBzaWRlIEkgZGlkbid0
IGZpbmQgYSBwcm9wZXIgcGxhY2UgaW4gdGhlIHVzYiBzdWJzeXN0ZW0gY29kZSBmb3IgYSB3b3Jr
YXJvdW5kIGJ1dCBpbnN0ZWFkDQpmb3VuZCBhbiB1bmRvY3VtZW50ZWQga2VybmVsIGFyZyAoKikg
dGhhdCBsaW1pdHMgdGhlIGRtYSBtYXNrIHRvIDMyIGJpdHM6DQp4aGNpLWhjZC5xdWlya3M9MHg4
MDAwMDAuDQoNCigqKSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNTA5MTU5
Lw0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQo=
