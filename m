Return-Path: <enorm@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by ozlabs.org (Postfix) with SMTP id 8E7B367CEE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 00:47:16 +1100 (EST)
Message-ID: <002801c7026f$019536d0$8709a8c0@class>
From: "enorm" <enorm@126.com>
To: <linuxppc-dev@ozlabs.org>
Subject: why need disable icache
Date: Tue, 7 Nov 2006 21:16:58 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01C702B2.0F4123F0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0025_01C702B2.0F4123F0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGksIGFsbA0KSSBoYXZlIGJlZW4gY29uZnVzZWQgYnkgY2FjaGUgcmVjZW50bHkuDQoxLiB3aHkg
bmVlZCB3ZSBkaXNhYmxlIGljYWNoZSBhbmQgZGNhY2hlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IHUtYm9vdCBjb2RlPw0KMi4gd2hlbiBjYW4gd2UgZW5hYmxlIHRoZW0gPw0KDQpZb3VyIGFuc3dl
cnMgd2lsbCBiZSBob25lc3RseSB3ZWxjb21lZC4NCg0KQmVzdCByZWdhcmRzDQpFbm9ybQ==

------=_NextPart_000_0025_01C702B2.0F4123F0
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI5NjMiIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj5IaSwgYWxsPC9GT05UPjwv
RElWPg0KPERJVj48Rk9OVCBzaXplPTI+SSBoYXZlIGJlZW4gY29uZnVzZWQgYnkgY2FjaGUgcmVj
ZW50bHkuPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+MS4gd2h5IG5lZWQgd2UgZGlz
YWJsZSBpY2FjaGUgYW5kIGRjYWNoZSBhdCB0aGUgYmVnaW5uaW5nIG9mIA0KdGhlIHUtYm9vdCBj
b2RlPzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjIuIHdoZW4gY2FuIHdlIGVuYWJs
ZSB0aGVtID88L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9E
SVY+DQo8RElWPjxGT05UIHNpemU9Mj5Zb3VyIGFuc3dlcnMgd2lsbCBiZSBob25lc3RseSB3ZWxj
b21lZC48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+
DQo8RElWPjxGT05UIHNpemU9Mj5CZXN0IHJlZ2FyZHM8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05U
IHNpemU9Mj5Fbm9ybTwvRk9OVD48L0RJVj48L0JPRFk+PC9IVE1MPg0K

------=_NextPart_000_0025_01C702B2.0F4123F0--
