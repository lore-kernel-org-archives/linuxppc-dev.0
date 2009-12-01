Return-Path: <tmarri@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BBBD5B7EE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 17:00:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: RE: ep440xs board boot problem
Date: Mon, 30 Nov 2009 21:49:55 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C08642F3E@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <288168.33010.qm@web52902.mail.re2.yahoo.com>
References: <288168.33010.qm@web52902.mail.re2.yahoo.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Allan Wang" <aiyuanwang@yahoo.com>,
	<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SXQgY291bGQgYmUgcmFtZGlzayBzaXplIGlzc3VlLiAgaWYgaXQgaXMgYmlnZ2VyIHRoYW4gNE1C
IHlvdSBtaWdodCBoYXZlIHRvIHBhc3MgcmFtaWRpc2tfc2l6ZT0xMDAwMDAgKDEwME1CIG9yID4g
eW91ciByYW1kaXNrIHNpemUpLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
bGludXhwcGMtZGV2LWJvdW5jZXMrdG1hcnJpPWFtY2MuY29tQGxpc3RzLm96bGFicy5vcmcgW21h
aWx0bzpsaW51eHBwYy1kZXYtYm91bmNlcyt0bWFycmk9YW1jYy5jb21AbGlzdHMub3psYWJzLm9y
Z10gT24gQmVoYWxmIE9mIEFsbGFuIFdhbmcNClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMzAsIDIw
MDkgOTozNSBQTQ0KVG86IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBl
cDQ0MHhzIGJvYXJkIGJvb3QgcHJvYmxlbQ0KDQpIZWxsbywgQWxsLA0KDQpJIGFtIG5ldyB0byB0
aGUgbGlzdC4gSSBhbSBzdGlsbCBuZXdiaWUgdG8gZW1iZWRkZWQgbGludXguIEkgaGF2ZSBib3Vn
aHQgYW4gZXA0NDB4cyBib2FyZCB3aGljaCBpcyBzaW1pbGFyIHRvIHNlcXVvaWEgYm9hcmQuIHUt
Ym9vdCBpcyB3b3JraW5nLiBJIGFtIHRyeWluZyB0byBtYWtlIGl0IHJ1biBsaW51eC4gIEkgaGF2
ZSB0aGUgZm9sbG93aW5nIHByb2JsZW1zIGFuZCBuZWVkIHlvdXIgaGVscC4gVGhhbmsgeW91IHZl
cnkgbXVjaDoNCg0KDQpJIGFtIHVzaW5nIGxpbnV4IGtlcm5lbCAyLjYuMzAuNC4gSSBlbmNvdW50
ZXIgMiBwcm9ibGVtczoNCjEuIEFmdGVyIGNvbnNvbGVfaW5pdCgpIGlzIGNhbGxlZCBpbnNpZGUg
c3RhcnRfa2VybmVsKCksIHRoZSBjb25zb2xlIHN0YXJ0cyBwcmludGluZyBnYXJiYWdlIGxpa2U6
DQpTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCA0IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVk
DQpzZXJpYWw4MjUwLjA6IHR0eVMwIGF0IE1NSU8gMHgxZWY2MDAzMDAgKGlycSA9IDE2KSBpcyBh
IDE2NTUwQQ0K77+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+9
77+977+977+977+977+977+977+977+977+977+977+977+977+977+9DQrvv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv70NCu+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
vQ0K77+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+9
77+977+977+977+977+977+977+977+977+977+977+977+9DQrvv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70uDQoyLiBJdCBwYWtpY3Mgd2hlbiBtb3Vu
dGluZyB0aGUgcm9vdCBmaWxlIHN5c3RlbShORlMpOg0KKGdkYikgYnQNCiMwICBwYW5pYyAoZm10
PTB4YzAyOTBlOTQgIlZGUzogVW5hYmxlIHRvIG1vdW50IHJvb3QgZnMgb24gJXMiKQ0KYXQga2Vy
bmVsL3BhbmljLmM6NzANCiMxICAweGMwMmQ4Y2UwIGluIG1vdW50X2Jsb2NrX3Jvb3QgKG5hbWU9
MHhjMDI5MGRlNCAiL2Rldi9yb290IiwgZmxhZ3M9MHg4MDAxKQ0KYXQgaW5pdC9kb19tb3VudHMu
YzoyNzINCiMyICAweGMwMmQ5MDg0IGluIHByZXBhcmVfbmFtZXNwYWNlICgpIGF0IGluaXQvZG9f
bW91bnRzLmM6NDE1DQojMyAgMHhjMDJkODFlYyBpbiBrZXJuZWxfaW5pdCAodW51c2VkPTx2YWx1
ZSBvcHRpbWl6ZWQgb3V0PikgYXQgaW5pdC9tYWluLmM6ODg1DQojNCAgMHhjMDAwZGU2MCBpbiBr
ZXJuZWxfdGhyZWFkICgpDQpUaGVyZSBpcyBhIHBhdGNoIGZvciBTZXF1b2lhIGJvYXJkIHRvIGRl
bGV0ZSAvY2hvc2VuIHBhcnQgaW4gc2VxdW9pYS5kdHMsIGlzIC9jaG9zZW4gcmVxdWlyZWQ/DQoN
CkFsbGFuDQoNCg0KDQogICAgICANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0DQpMaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZw0KaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBj
LWRldg0K
