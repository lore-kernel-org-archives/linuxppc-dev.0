Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhPds4dwLzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:13:37 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Zhiqiang Hou' <zhiqiang.hou@nxp.com>, Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCH] powerpc/config: Disable the 4KiB erase granularity of
 SPI flash
Date: Fri, 8 Apr 2016 16:01:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D54DC814C@AcuExch.aculab.com>
References: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1459980089.32510.78.camel@buserror.net>
 <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
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

RnJvbTogWmhpcWlhbmcgSG91DQo+IFNlbnQ6IDA3IEFwcmlsIDIwMTYgMDQ6MTcNCi4uLg0KPiA+
IElzIHRoZXJlIGEgcmVhc29uIHNwZWNpZmljIHRvIDg1eHggdG8gaGF2ZSBhIGRpZmZlcmVudCBk
ZWZhdWx0IHRoYW4gZXZlcnkgb3RoZXINCj4gPiBwbGF0Zm9ybSBleGNlcHQgbHBjMTh4eD8gIFRo
ZSBkZXNjcmlwdGlvbiBvZiBNVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUw0KPiA+IGFja25vd2xl
ZGdlcyB0aGF0IGVyYXNlIHNwZWVkIGlzIGEgdHJhZGVvZmYuICBXaHkgaXMgdGhhdCBjb25jZXJu
IG1vcmUNCj4gPiBjb21wZWxsaW5nIG9uIDg1eHggdGhhbiBlbHNld2hlcmU/DQo+ID4NCj4gDQo+
IEkgZG9uJ3Qgd2FudCB0byBzcGVjaWZ5IDg1eHgsIGJ1dCBjb25maWdzIG9mIGZzbC4gSSdtIHN0
aWxsIGNvbmZ1c2luZyAgYWJvdXQgc28gbWFueQ0KPiBjb25maWdzLiBXaWxsIGFkZCBvdGhlciBw
bGF0Zm9ybXMgaWYgbmVjZXNzYXJ5Lg0KPiANCj4gRm9yIHRoaXMgcGF0Y2gsIGl0IHRha2VzIGFi
b3V0IDEzIG1pbnMgdG8gZXJhc2UgNjRNaUIgYnkgc3Vic2VjdG9yIGVyYXNlIGNvbW1hbmQNCj4g
KDRLaUIgcGVyIHRpbWUpLCBidXQgdGFrZXMgMiBtaW5zIGJ5IHNlY3RvciBlcmFzZSBjb21tYW5k
KDY0S2lCIHBlciB0aW1lKS4gSXQgaXMNCj4gY29uc3BpY3VvdXMgZGVjcmVhc2UuIFdoeSBpdCB1
c2VzIHRoZSA0S2lCIGdyYW51bGFyaXR5IGJ5IGRlZmF1bHQsIHdoYXQncyB0aGUNCj4gYmVuZWZp
dD8NCg0KU2hvdWxkIGl0IGJlIGRvaW5nIDY0SyBlcmFzZXMgZm9sbG93ZWQgYnkgMCB0byAxNSA0
SyBlcmFzZXMgZm9yIGFueSBmaW5hbCBmcmFnbWVudD8NCg0KCURhdmlkDQoNCg==
