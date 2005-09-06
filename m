Return-Path: <jason_chen@usish.com>
Received: from ms.usish.com (ms.usish.com [61.152.162.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A11C3680F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 16:55:31 +1000 (EST)
Received: from usish001432 ([192.168.58.58]) (authenticated bits=0)
	by ms.usish.com (8.12.8/8.12.8) with ESMTP id j866rucE010565
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Sep 2005 14:54:01 +0800
Message-Id: <200509060654.j866rucE010565@ms.usish.com>
Date: Tue, 6 Sep 2005 14:55:23 +0800
From: "Jason Chen" <jason_chen@usish.com>
To: "linuxppc-embedded " <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

aGksYWxsLA0KVW5saWtlIG5vcm1hbGx5LEkgYnVpbHQgYSBNUEM4MjQ4IHN5c3RlbSB3aG9zZSB1
LWJvb3Qgc2V0IGZsYXNoIGxvY2F0aW5nIGZyb20gMHhmZTAwMDAwMCB0byAweGZlN2ZmZmZmICg4
TSksYW5kIGJ1cm5lZCB0aGUgdS1ib290IG9uIDB4ZmU3MDAwMDAuDQpUaGUgSFJDVyB3YXMgc2V0
IHRvIENJUCA9IDAgd2hpY2ggbWVhbnMgdGhhdCBleGNlcHRpb25zIGFyZSB2ZWN0b3JlZCB0byB0
aGUgcGh5c2ljYWwgYWRkcmVzcyAweEZGRm5fbm5ubi4NClRoZSB1LWJvb3QgYW5kIGtlcm5lbCBy
dW4gc3VjY2Vzc2Z1bGx5LGJ1dCBmYWlsZWQgd2hpbGUgZXhlY3V0ZSB0aGUgY29tbWFuZCByZWJv
b3QuSSBmb3VuZCBrZXJuZWwgcnVuIG04MjYwX2dvcm9tICBiZWxvdyBhdCB0aGUgZW5kIG9mIHJl
Ym9vdCBiZSBjYWxsZWQuSW4gdGhlc2UgY29kZXMsIE1TUl8gZXF1YWwgTVNSX01FfE1TUl9SSSBv
cmlnaW5hbGx5LGFmdGVyIGJlIHNldCB0byBNU1JfTUV8TVNSX1JJfE1TUl9JUCx0aGUgcmVib290
IGNhbiBydW4gc3VjY2Vzc2Z1bGx5Lg0KSSB3YW5uYSBhc2ssaW4gdGhpcyBjYXNlLCBpcyB0aGVy
ZSBhIHJlc2V0IGFjdGlvbj8gaWYgdGhlcmUgaXMsIHdoYXQgY2F1c2UgaXQ/IGlmIHRoZXJlIGlz
J250LCB0aGUgY3B1IHJ1biB0byBmbGFzaCgweGZlNzAwMTAwKSBkaXJlY3RseSx0aGVuIHdoeSBN
U1JbaXBdIGhhcyB0byBiZSBzZXQgdG8gMT8gYmVjYXVzZSBpbiBteSBzeXN0ZW0sIGV4Y2VwdGlv
bnMgYWRkcmVzcyAweGZmZm5fbm5ubiBkaWQgbm90IGV4aXN0IGF0IGFsbC4NCkFuZCBtb3JlLHdo
eSBteSB1LWJvb3QgY291bGQgcnVuIHN1Y2Nlc3NmdWxseSB3aGlsZSBNU1JbaXBdID0gMSBidXQg
cmVhbCBleGNlcHRpb24gdmVjdG9ycyBsb2NhdGUgYXQgMHhmZTAwXzBuMDA/DQoNCiAgICAuZ2xv
YmwgIG04MjYwX2dvcm9tIC8qIHI0ID0gYWRkciBpbiB0aGUgcm9tLGkgc2V0IGl0IHRvIDB4ZmU3
MDAxMDAgKi8NCm04MjYwX2dvcm9tOg0KCW1mbXNyCXIwDQoJcmx3aW5tCXIwLHIwLDAsMTcsMTUJ
LyogY2xlYXIgTVNSX0VFIGluIHIwICovDQoJc3luYw0KCW10bXNyCXIwDQoJc3luYw0KCW1mc3By
CXIxMSwgSElEMA0KCWxpcwlyMTAsIDANCglvcmkJcjEwLHIxMCxISUQwX0lDRXxISUQwX0RDRQ0K
CWFuZGMJcjExLCByMTEsIHIxMA0KCW10c3ByCUhJRDAsIHIxMQ0KCWlzeW5jDQoJbGkJcjUsIE1T
Ul8NCglsaXMJcjYsMmZAaA0KCWFkZGlzCXI2LHI2LC1LRVJORUxCQVNFQGgNCglvcmkJcjYscjYs
MmZAbA0KCW10c3ByCVNSUjAscjYNCgltdHNwcglTUlIxLHI1DQoJaXN5bmMNCglzeW5jDQoJcmZp
DQoyOg0KCW10bHIJcjQNCglibHINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
ClRoYW5rcyB2ZXJ5IG11Y2ghDQpKYXNvbg0KoaGhoaGhoaGhoaGhoaGhoQ0KoaGhoaGhoaGhoaGh
oaGhoaGhoaENCg==
