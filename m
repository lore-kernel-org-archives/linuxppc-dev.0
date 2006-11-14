Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 052D867C9C
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 02:49:21 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAEFnKKL020107
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:49:20 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAEFnKcs020095
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:49:20 +0900 (JST)
Message-ID: <4559E579.2070101@am.sony.com>
Date: Tue, 14 Nov 2006 07:49:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/16] patches for 2.6.20
References: <4554DA4D.9010909@am.sony.com> <200611110256.44140.arnd@arndb.de>
In-Reply-To: <200611110256.44140.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

QXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gRnJpZGF5IDEwIE5vdmVtYmVyIDIwMDYgMjE6MDAs
IEdlb2ZmIExldmFuZCB3cm90ZToNCj4+IFRoaXMgaXMgdGhlIHNldCBvZiBwYXRjaGVzIEkgaGF2
ZSBxdWV1ZWQgZm9yIDIuNi4yMC4g77+9UGF0Y2hlcyAxLTYgaGF2ZQ0KPj4gYWxyZWFkeSBiZWVu
IHBvc3RlZCwgYnV0IEkgZGlkIHNvbWUgcmUtd29yayBvbiBhIGZldyB0byBicmluZyB0aGVtIHVw
DQo+PiB0byB0aGUgbGF0ZXN0IHBvd2VycGMuZ2l0LiDvv71QYXRjaGVzIDctMTYgYXJlIG5ldyBh
bmQgYWRkIHRoZSBjb3JlDQo+PiBwbGF0Zm9ybSBzdXBwb3J0IGZvciB0aGUgUFMzIGdhbWUgY29u
c29sZS4NCj4+IA0KPj4gRm9yIHRoZSBjb252ZW5pZW5jZSBvZiBhbnlvbmUgaW50ZXJlc3RlZCwg
SSBoYXZlIHB1dCB0aGlzIHBhdGNoc2V0LCBwbHVzDQo+PiBhIGZldyBvdGhlciBkcml2ZXJzIEkg
YW0gd29ya2luZyBvbiB3aXRoIHNvbWUgaW5mbyBoZXJlOg0KPiANCj4gSSd2ZSB0YWtlbiB0aGUg
cGF0Y2hlcyB5b3Ugc3VibWl0dGVkIG5vdyBhbmQgbWVyZ2VkIHRoZW0gd2l0aCBteSBzZXJpZXMs
DQo+IHdoaWNoIGFscmVhZHkgY29udGFpbnMgdGhlIGJpZyBzZXQgb2YgcGF0Y2hlcyB0aGF0IEJl
bmphbWluIEhlcnJlbnNjaG1pZHQNCj4gc2VudCBvdXQgZWFybGllciB0aGlzIHdlZWsuDQo+IA0K
PiBJIGhhdmUgYSB2ZXJzaW9uIGZvciAyLjYuMTktcmM1IGFuZCBvbmUgYmFzZWQgb24gdGhlIDIu
Ni4xOCByZWxlYXNlDQo+IG9uIGtlcm5lbC5vcmc6DQo+IA0KPiBodHRwOi8va2VybmVsLm9yZy9w
dWIvbGludXgva2VybmVsL3Blb3BsZS9hcm5kL3BhdGNoZXMvMi42LjE4LWFybmQ2Lw0KPiBodHRw
Oi8va2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Blb3BsZS9hcm5kL3BhdGNoZXMvMi42LjE5
LXJjNS1hcm5kMS8NCj4gaHR0cDovL2tlcm5lbC5vcmcvZ2l0Lz9wPWxpbnV4L2tlcm5lbC9naXQv
YXJuZC9jZWxsLTIuNi5naXQNCj4gZ2l0Oi8va2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvYXJuZC9jZWxsLmdpdCAyLjYuMTktcmM1LWFybmQxDQo+IA0KPiBUaGlzIGlzIHRoZSBm
aXJzdCByZWxlYXNlIHRoYXQgY29tYmluZXMgc3VwcG9ydCBmb3IgdGhlIElCTSBRUzIwIGJsYWRl
LA0KPiBib2FyZHMgYmFzZWQgb24gdGhlIG5ldyBBeG9uIHNvdXRoIGJyaWRnZSBhcyB3ZWxsIGFz
IGZpbmFsbHkgdGhlDQo+IFBsYXlzdGF0aW9uIDMuDQoNCkkgbWVyZ2VkIGluIHlvdXIgY2hhbmdl
cyBhbmQgYWRkZWQgdGhlIHJlcXVlc3RzIGZyb20gdmFyaW91cyBjb21tZW50cw0KdG8gbXkgcGF0
Y2hzZXQgYW5kIHJlYmFzZWQgaXQgdG8gdGhlIGxhdGVzdCBwb3dlcnBjLmdpdCB0cmVlICh3aGlj
aCBub3cNCmhhcyBtYW55IG9mIEJlbidzIHBhdGhlcykuICBUaGUgcmVzdWx0IGlzIGhlcmU6DQoN
CiAgaHR0cDovLzY3LjExNy4xMzYuMTY0L3B1Yi9jZWxsL2xpbnV4LTIuNi4xOS1wczNwZi4wNi4x
MS4xNC50YXIuYnoyDQoNCkknbGwgZG8gc29tZSBtb3JlIGNsZWFudXAgYW5kIHRlc3Rpbmcgb24g
aXQsIGluY2x1ZGluZyBtdWx0aS1wbGF0Zm9ybQ0KY29uZmlnIHRlc3RzIGluIHRoZSBuZXh0IGZl
dyBkYXlzLg0KDQotR2VvZmYNCg==
