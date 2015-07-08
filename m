Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1861A105E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:59:16 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiaobo
 Xie" <X.Xie@freescale.com>
Subject: RE: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
Date: Wed, 8 Jul 2015 03:26:21 +0000
Message-ID: <SN1PR0301MB1550F2C30F1393CA26F4FF3B9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433398423.3415.34.camel@freescale.com>
 <SN1PR0301MB1550B0B2F863A80559FE8B6B9BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433457659.31070.2.camel@freescale.com>
 <SN1PR0301MB155069ED5F42D54AF2A769F09B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436324117.2658.64.camel@freescale.com>
In-Reply-To: <1436324117.2658.64.camel@freescale.com>
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

Tm93IHRoZSBwb2ludCBpcywgZ2VuYWxsb2MgaXMgbm90IHNvIHByb3BlciB0byBxZSBtdXJhbSB3
aGlsZSByaGVhcCBpcyB3cml0dGVuIHRvIG1hbmFnZSBtdXJhbSwNCmlmIHVzZSBnZW5hbGxvYyBp
bnN0ZWFkIG9mIHJoZWFwLCB0aGVyZSB3aWxsIGJlIGFtb3VudHMgb2Ygd29yayB0byBkby4NCkkg
aGF2ZSBhIHN1Z2dlc3Rpb24sIGhvdyBhYm91dCB0byBwdXQgcmhlYXAgdW5kZXIgZHJpdmVycy9z
b2MvcWUsIGJlY2F1c2UgcmhlYXAgaXMgDQpUbyBtYW5hZ2UgbXVyYW0gd2hlbiBpdCBpcyBhZGRl
ZCB0byBzZGsuDQoNCkJlc3QgUmVnYXJkcw0KWmhhbyBRaWFuZw0KDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDA4LCAyMDE1IDEwOjU1IEFNDQo+IFRvOiBaaGFvIFFpYW5nLUI0NTQ3NQ0KPiBD
YzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IFhpZSBYaWFvYm8tUjYzMDYxDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSByaGVhcDogbW92ZSByaGVhcC5jIGZyb20gYXJjaC9wb3dl
cnBjL2xpYi8gdG8NCj4gbGliLw0KPiANCj4gT24gVHVlLCAyMDE1LTA3LTA3IGF0IDIxOjU0IC0w
NTAwLCBaaGFvIFFpYW5nLUI0NTQ3NSB3cm90ZToNCj4gPiBJIG5lZWQgdG8gZW5zdXJlIG9uZSB0
aGluZywNCj4gPiBJbiB5b3VyIHBvaW50LCB5b3Ugd2FudCBtZSB0byB1c2UgbGliL2dlbmFsbG9j
LmMgaW5zdGVhZCBvZiByaGVhcC5jLg0KPiA+IE9yIGp1c3QgdGhpbmsgcmhlYXAuYyBpcyBub3Qg
cHJvcGVyIHRvIHB1dCBpbnRvIGxpYj8NCj4gPg0KPiA+IEJlc3QgUmVnYXJkcw0KPiA+IFpoYW8g
UWlhbmcNCj4gDQo+IEkgd2FudCB5b3UgdG8gdXNlIGxpYi9nZW5hbGxvYy5jLg0KPiANCj4gLVNj
b3R0DQoNCg==
