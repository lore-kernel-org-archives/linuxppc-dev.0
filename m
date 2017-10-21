Return-Path: <sbates@raithlin.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0125.outbound.protection.outlook.com [104.47.41.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yK5X826MWzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Oct 2017 02:03:34 +1100 (AEDT)
From: "Stephen  Bates" <sbates@raithlin.com>
To: Balbir Singh <bsingharora@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
Date: Sat, 21 Oct 2017 15:03:29 +0000
Message-ID: <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
In-Reply-To: <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
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

DQo+IEkgYW0gZ3Vlc3NpbmcgdGhhdCB0aGUgaG90cGx1ZyBvZiBaT05FX0RFVklDRSBtZW1vcnkg
d2FzIGRvbmUNCj4gaW5jb3JyZWN0bHkgYXMgaXQgbGVhZCB0byBIUFQgcmVzaXppbmcgKHRoZSBz
eXN0ZW0gdGhpbmtpbmcgdGhpcyBpcw0KPiBub3JtYWwgbWVtb3J5KS4gSWRlYWxseSBvbmUgd291
bGQgZXhwZWN0IHRoYXQgdGhlIGRyaXZlciB3b3VsZCBvbmxpbmUNCj4gWk9ORV9ERVZJQ0UgbWVt
b3J5IGFuZCBub3QgZ28gdGhyb3VnaCB0aGUgSE9UUExVRyBwYXRoLiBBcmUgeW91IHVzaW5nDQo+
IGRldm1fbWVtcmVtYXBfcGFnZXMoKSBwYXRoIHRvIGFkZCB0aGVzZSBwYWdlcz8NCj4NCg0KVGhh
bmtzIGZvciB0aGUgcmVzcG9uc2UgQmFsYmlyLiBZZXMgd2UgdXNlIGRldm1fbWVtcmVtYXBfcGFn
ZXMoKSB0byBhZGQgdGhlc2UgcGFnZXMgYW5kIGl0IGRvZXMgY2FsbCBhcmNoX2FkZF9tZW1vcnko
KS4gV2UgZG8gaGF2ZSBhbiBhbHRlcm5hdGUgc2V0IG9mIHBhdGNoZXMgd2hpY2ggc3RpbGwgY2Fs
bHMgZGV2bV9tZW1yZW1hcF9wYWdlcygpIGJ1dCBjYW4gdGFrZSBhIGZsYWcgdG8gaW5kaWNhdGUg
dGhlIG1lbW9yeSBiZWluZyBhZGRlZCBpcyBpbyBtZW1vcnkgYW5kIHVzZXMgaW9fcmVtYXAoKSBy
YXRoZXIgdGhhbiBhcmNoX2FkZF9tZW1vcnkoKSBmb3IgdGhhdCB0eXBlIG9mIG1lbW9yeSBbMV0u
IFdvdWxkIHRoYXQgYmUgYSBiZXR0ZXIgYXBwcm9hY2ggZm9yIHRoaXMgYXJjaD8gSSBjYW4gdHJ5
IGFuZCBhcHBseSB0aGlzIHBhdGNoIGJ1dCBfX2FkZF9wYWdlcygpIGhhcyBnb25lIHRocm91Z2gg
c29tZSBjaGFuZ2VzIHJlY2VudGx5IHNvIGl0IHdpbGwgdGFrZSBtZSBhIGZldyBkYXlzIHRvIGdl
dCB0byB0aGF0LiANCg0KU3RlcGhlbg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3NiYXRlczEz
MDI3Mi9saW51eC1wMnBtZW0vY29tbWl0L2FjNzM1ODcxZmNkMmM2M2JkMzNjODE0YWEzOTQxY2Ez
ZWY1M2I2MzYNCg0KDQo=
