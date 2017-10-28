Return-Path: <sbates@raithlin.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0126.outbound.protection.outlook.com [104.47.37.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yPY0J4vVdzDrVv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 07:54:53 +1100 (AEDT)
From: "Stephen  Bates" <sbates@raithlin.com>
To: Oliver <oohall@gmail.com>
CC: Balbir Singh <bsingharora@gmail.com>, Logan Gunthorpe
 <logang@deltatee.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
Date: Sat, 28 Oct 2017 20:54:47 +0000
Message-ID: <B75498AD-593B-45E0-AE9D-CA00C7A2885F@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
 <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
 <20171023135338.58d0ab31@MiWiFi-R3-srv>
 <C65BF19B-49B3-480E-9435-17949645B992@raithlin.com>
 <CAOSf1CGx2E3dOPPSrKOxHahGcu8BjRq02xeyEitPmiwoFcdo+w@mail.gmail.com>
 <CAOSf1CHWZfEyK-oM+4dPpamX-XbxM13mtHjKoYWGEdmQ7wCd_g@mail.gmail.com>
In-Reply-To: <CAOSf1CHWZfEyK-oM+4dPpamX-XbxM13mtHjKoYWGEdmQ7wCd_g@mail.gmail.com>
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

DQpPbGl2ZXINCg0KPlRoZSBhbHRlcm5hdGl2ZSBhcHByb2FjaCB5b3UgbWVudGlvbmVkIHRoYXQg
dXNlcyBpb3JlbWFwKCkgc2hvdWxkIHdvcmsNCj5maW5lIHRob3VnaC4NCg0KR3JlYXQsIHRoYW5r
cyBmb3IgdGhpcyB1c2VmdWwgaW5mb3JtYXRpb24gT2xpdmVyLiBJIGFtIHdvcmtpbmcgb24gcmVi
YXNpbmcgdGhlIGlvcmVtYXAoKSANCnBhdGNoIG9uIDQuMTQgYW5kIHdpbGwgbGV0IHlvdSBrbm93
IGhvdyBpdCBnb2VzLg0KDQo+IEFsc28sIEFsZXh5ICgrY2MpIHNhaWQgaGUgd2FzIGludGVyZXN0
ZWQgaW4gdHJ5aW5nIHRoaXMgb24gc29tZSByZWFsDQo+IGhhcmR3YXJlLiBJcyB0aGVyZSBhIHRl
c3Qgc3VpdGUgZm9yIHAycG1lbSBmbG9hdGluZyBhcm91bmQgdGhhdCBoZSBjYW4NCj4gdXNlPw0K
DQpFeGNlbGxlbnQhIEkgdHlwaWNhbGx5IHVzZSBwMnBtZW0tdGVzdCBbMV0uIFlvdSB3aWxsIG5l
ZWQgYXQgbGVhc3Qgb25lIE5WTWUgU1NEIGFuZCBvbmUgcDJwbWVtIGNhcGFibGUgZGV2aWNlIGFu
ZCB5b3UgKm1pZ2h0KiBuZWVkIHRvIHBsYWNlIHRob3NlIHR3byBkZXZpY2VzIGJlaGluZCBhIFBD
SWUgc3dpdGNoIGFuZCBjb25maWd1cmUgQUNTIFsyLTNdIGRlcGVuZGluZyBvbiBob3cgdGhlIENQ
VSBSQyB0cmVhdHMgcGVlciB0byBwZWVyIFBDSSBUTFBzLiBJIGFtIGhhcHB5IHRvIGhlbHAgQWxl
eCBzZXQgdGhpcyBhbGwgdXAgc28gcmVhY2ggb3V0IGVpdGhlciBwdWJsaWNhbGx5IG9yIHByaXZh
dGVseSBpZiB5b3UgbGlrZS4gSSBqdXN0IGFkZGVkIGEgKGhvcGVmdWxseSkgZGVjZW50IFJFQURN
RSB0byBoZWxwIGdldCBwZW9wbGUgc3RhcnRlZC4NCg0KU3RlcGhlbg0KDQpbMV0gaHR0cHM6Ly9n
aXRodWIuY29tL3NiYXRlczEzMDI3Mi9wMnBtZW0tdGVzdA0KWzJdIGh0dHBzOi8vd3d3LnN1cGVy
bWljcm8uY29tL3N1cHBvcnQvZmFxcy9mYXEuY2ZtP2ZhcT0yMDczMg0KWzNdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE3LzEwLzI2LzY3OCANCg0K
