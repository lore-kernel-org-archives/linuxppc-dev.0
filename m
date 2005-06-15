Return-Path: <jason_chen@usish.com>
Received: from ms.usish.com (unknown [61.152.162.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42A0667B3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 16:05:33 +1000 (EST)
Received: from usish001432 ([192.168.58.33]) (authenticated bits=0)
	by ms.usish.com (8.12.8/8.12.8) with ESMTP id j5F5VMPK006235
	for <linuxppc-embedded@ozlabs.org>; Wed, 15 Jun 2005 13:31:22 +0800
Message-Id: <200506150531.j5F5VMPK006235@ms.usish.com>
Date: Wed, 15 Jun 2005 13:35:31 +0800
From: "Jason Chen" <jason_chen@usish.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: change the SDRAM address
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

aGksYWxsLA0KSSBhbSBhIG5ld2VyLkkgd29ya2VkIG9uIGEgcGxhdGZvcm0gYmFzZWQgb24gTVBD
ODI0OC4NClRoZSA2NE0gU0RSQU0gdXNlIENTMixhbmQgaXQncyBiYXNlIGFkZHJlc3MgaXMgMHgw
MDAwMDAwMCxCUjI9MHgwMDAwMDA0MSxPUjI9ZmMwMDJjZDAuDQpJdCdzIGp1c3QgYSBzaW1wbGUg
aXNzdWUsSSB3YW50IHRvIGNoYW5nZSB0aGUgYmFzZSBhZGRyZXNzIG9mIHRoZSBTRFJBTSBmcm9t
IDB4MDAwMDAwMDAgdG8gMHgwMzAwMDAwMCxJIHRob3VnaHQgY2hhbmdlIHRoZSBCUjIgcmVnaXN0
ZXIgdG8gMHgwMzAwMDA0MSB3YXMgb2ssYnV0IHRoZSByZWFsIHRoaW5nIGlzIHRoYXQgeW91IGNh
biByZWFkL3dyaXRlIHRoZSBhcmVhIG9mIDB4MDMwMDAwMDAgdG8gMHgwM2ZmZmZmZixidXQgdGhl
IGFyZWEgYWJvdmUgdGhlIDB4MDQwMDAwMDAgY2FuIG5vdCBiZSB3cml0dGVuIGFuZCBhbGwgYmUg
cmVhZCBhcyAweDAuDQpJIHdhbnQgdG8ga25vdyBhbSBJIHJpZ2h0IHRvIGNoYW5nZSB0aGUgYmFz
ZSBhZGRyZXNzIGp1c3QgYnkgY2hhbmdlIHRoZSBCUjI/DQpJcyB0aGVyZSBzb21lIG90aGVyIHNo
b3VsZCBiZSBjaGFuZ2U/IE9yIGl0IG1heSBjb25uZWN0IHdpdGggYSBoYXJkd2FyZSBjaGFuZ2U/
DQoNClRoYW5rcw0KDQpKYXNvbg0KDQoJDQoNCqGhoaGhoaGhoaGhoQ0KDQqhoaGhoaGhoaGhoaGh
oaGhDQqhoaGhoaGhoaGhoaGhoaGhDQqhoaGhoaGhoaGhoaGhoaGhoaGhoQ0K
