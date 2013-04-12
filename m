Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 2C08C2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2013 05:05:51 +1000 (EST)
Date: Fri, 12 Apr 2013 15:05:46 -0400 (EDT)
Message-Id: <20130412.150546.1401935323621074376.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH v2] net: mv643xx_eth: remove deprecated inet_lro support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1365771339.4459.0.camel@edumazet-glaptop>
References: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365758400-12565-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365771339.4459.0.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 w@1wt.eu, smoch@web.de, paulus@samba.org, linux-arm-kernel@lists.infradead.org,
 dale@farnsworth.org, bhutchings@solarflare.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, florian@openwrt.org, buytenh@wantstofly.org,
 sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogRXJpYyBEdW1hemV0IDxlcmljLmR1bWF6ZXRAZ21haWwuY29tPg0KRGF0ZTogRnJpLCAx
MiBBcHIgMjAxMyAwNTo1NTozOSAtMDcwMA0KDQo+IE9uIEZyaSwgMjAxMy0wNC0xMiBhdCAxMToy
MCArMDIwMCwgU2ViYXN0aWFuIEhlc3NlbGJhcnRoIHdyb3RlOg0KPj4gV2l0aCByZWNlbnQgc3Vw
cG9ydCBmb3IgR1JPLCB0aGVyZSBpcyBubyBuZWVkIHRvIGtlZXAgYm90aCBMUk8gYW5kDQo+PiBH
Uk8uIFRoaXMgcGF0Y2ggdGhlcmVmb3JlIHJlbW92ZXMgdGhlIGRlcHJlY2F0ZWQgaW5ldF9scm8g
c3VwcG9ydA0KPj4gZnJvbSBtdjY0M3h4X2V0aC4gVGhpcyBpcyB3b3JrIGlzIGJhc2VkIG9uIGFu
IGV4cGVyaW1lbnRhbCBwYXRjaA0KPj4gcHJvdmlkZWQgYnkgRXJpYyBEdW1hemV0IGFuZCBXaWxs
eSBUYXJyZWF1Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gSGVzc2VsYmFydGgg
PHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+DQo+PiBCYXNlZC1vbi1wYXRjaC1ieTog
RXJpYyBEdW1hemV0IDxlcmljLmR1bWF6ZXRAZ21haWwuY29tPg0KPj4gQmFzZWQtb24tcGF0Y2gt
Ynk6IFdpbGx5IFRhcnJlYXUgPHdAMXd0LmV1Pg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGZyb20gdjE6
DQo+PiAtIGFsc28gcmVtb3ZlIElORVRfTFJPIGZyb20gS2NvbmZpZyAoUmVwb3J0ZWQgYnkgRXJp
YyBEdW1hemV0KQ0KPiANCj4gVGhhbmtzIGZvciBmaW5pc2hpbmcgdGhpcyBwYXRjaA0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KDQpBcHBs
aWVkLCBidXQgdGhpcyBkcml2ZXIgaXMgZnVsbCBvZiBza2VsZXRvbnM6DQoNCmRyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvbXY2NDN4eF9ldGguYzogSW4gZnVuY3Rpb24goXJ4cV9yZWZpbGyi
Og0KZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9tdjY0M3h4X2V0aC5jOjYxODoxOTogZXJy
b3I6IGludmFsaWQgb3BlcmFuZHMgdG8gYmluYXJ5IC0gKGhhdmUgoXNrX2J1ZmZfZGF0YV90oiBh
bmQgoXVuc2lnbmVkIGNoYXIgKqIpDQoNCndoaWNoIGlzOg0KDQoJCXNpemUgPSBza2ItPmVuZCAt
IHNrYi0+ZGF0YTsNCg0KdGhhdCBpcyBhYnNvbHV0ZWx5IG5vdCBhIGxlZ2FsIGNvbXB1dGF0aW9u
Lg0KDQpJdCBoYXBwZW5zIHRvIGJlIGluIHRoZSBvbmx5IGNvbmZpZ3VyYXRpb24gZm9yIHdoaWNo
IHRoaXMgZHJpdmVyDQpjYW4gYmUgZW5hYmxlZCBpbiBLY29uZmlnIGJ1dCB0aGF0IGlzIG5vIGV4
Y3VzZSBmb3IgaXQgOi0pDQo=
