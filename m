Return-Path: <Bharat.Bhushan@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21DCE2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 15:11:15 +1100 (EST)
Received: from mail43-co1 (localhost [127.0.0.1])	by mail43-co1-R.bigfish.com
 (Postfix) with ESMTP id 84C7FBC079D	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 11 Nov 2013 04:11:12 +0000 (UTC)
Received: from CO1EHSMHS027.bigfish.com (unknown [10.243.78.236])	by
 mail43-co1.bigfish.com (Postfix) with ESMTP id D0896B4003F	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 04:11:10 +0000 (UTC)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: Dongsheng Wang <Dongsheng.Wang@freescale.com>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
Date: Mon, 11 Nov 2013 04:11:09 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071EEABB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C34C1@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B195F@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C362B@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B33C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <1382124094.7979.885.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BBC86@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383601901.25829.33.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BC83B@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071E442A@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BD119@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383787214.23598.96.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BF40C@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010BF40C@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+IFRob3NlIGNvZGVzIGp1c3QgZm9yIGRpc2N1c3Mgd2l0aCBCaGFyYXQuIEhlIHdhbnQgdG8g
bWFrZSBvbmUgZmxvdyBhdA0KPiA+ICJzaG93X3B3MjBfd2FpdF90aW1lIi8iIHNob3dfYWx0aXZl
Y19pZGxlX3dhaXRfdGltZSIgZnVuY3Rpb24uIElmIHdlDQo+ID4gZG8gdGhhdCwgd2UgbmVlZCB0
byBpbml0aWFsaXplIHB3MjBfd3QvYWx0aXZlY19pZGxlX3d0Lg0KPiA+DQo+IEkgd2lsbCBrZWVw
IHRoaXMgc3R1ZmYgYXQgInNob3dfcHcyMF93YWl0X3RpbWUiLyJzaG93X2FsdGl2ZWNfaWRsZV93
YWl0X3RpbWUiDQo+IGFuZCBhZGQgYSBjb21tZW50IGJlZm9yZSBvdXIgZGlzY3Vzc2lvbi4NCj4g
DQo+IC8qDQo+ICAqIElmIHRoZSAidmFsdWUiIGxlc3MgdGhhbiAxMCwgdGhpcyB3aWxsIG92ZXJm
bG93Lg0KPiAgKiBGcm9tIGJlbmNobWFyayB0ZXN0LCB0aGUgZGVmYXVsdCB3YWl0IGJpdCB3aWxs
IG5vdCBiZSBzZXQgbGVzcyB0aGFuIDEwYml0Lg0KPiAgKiBCZWNhdXNlIDEwIGJpdCBjb3JyZXNw
b25kcyB0byB0aGUgd2FpdCBlbnRyeSB0aW1lIGlzIDQzOTM3NTU3MzQwMTk5OTYwOShucyksDQo+
ICAqIGZvciB3YWl0LWVudHJ5LWlkbGUgdGltZSB0aGlzIHZhbHVlIGxvb2tzIHRvbyBsb25nLCBh
bmQgd2UgY2Fubm90IHVzZSB0aG9zZQ0KPiAgKiAibG9uZyIgdGltZSBhcyBhIGRlZmF1bHQgd2Fp
dC1lbnRyeSB0aW1lLiBTbyBvdmVyZmxvdyBjb3VsZCBub3QgaGF2ZSBoYXBwZW5lZA0KPiAgKiBh
bmQgd2UgdXNlIHRoaXMgY2FsY3VsYXRpb24gbWV0aG9kIHRvIGdldCB3YWl0LWVudHJ5LWlkbGUg
dGltZS4NCj4gICovDQoNCkkgdGhpbmsgbm93IHdlIHdpbGwgdXNlIHNhbWUgY2FsY3VsYXRpb24g
Y29kZSBmb3IgZGVmYXVsdCB2YWx1ZSBhbmQgdXNlciBzZXQgdmFsdWUsIHNvIGFkZGluZyB0aGUg
Y29tbWVudCBpcyBub3Qgc3VmZmljaWVudCwgd2Ugc2hvdWxkIGVycm9yIG91dCBmcm9tIHRoZSBj
b2RlIGlmIHZhbHVlIGlzIGxlc3MgdGhhbiAxMC4gQXMgZGVmYXVsdCB2YWx1ZSBpcyBub3QgbGVz
cyB0aGFuIDEwIHNvIHRoaXMgd2lsbCBhbHdheXMgd29yayB3aXRoIGRlZmF1bHQgdmFsdWUgYnV0
IGlmIHVzZXIgdHJpZXMgdG8gc2V0IGxlc3MgdGhhbiAxMCB0aGVuIGVycm9yIG91dCBhbmQgYXNr
IHVzZXIgdG8gdHJ5IG1vcmUgdGhhbiA5Lg0KDQotQmhhcmF0DQo=
