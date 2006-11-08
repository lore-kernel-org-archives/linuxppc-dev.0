Return-Path: <enorm@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by ozlabs.org (Postfix) with SMTP id 5A72867C99
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 12:51:26 +1100 (EST)
Message-ID: <000e01c702d8$62cd9460$8709a8c0@class>
From: "Jackson" <enorm@126.com>
To: <linuxppc-dev@ozlabs.org>
Subject: why need disable icache
Date: Wed, 8 Nov 2006 09:51:19 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C7031B.70B07000"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C7031B.70B07000
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

DQoNCkhpLCBhbGwNCkkgaGF2ZSBiZWVuIGNvbmZ1c2VkIGJ5IGNhY2hlIHJlY2VudGx5Lg0KMS4g
d2h5IG5lZWQgd2UgZGlzYWJsZSBpY2FjaGUgYW5kIGRjYWNoZSBhdCB0aGUgYmVnaW5uaW5nIG9m
IHRoZSB1LWJvb3QgY29kZT8NCjIuIHdoZW4gY2FuIHdlIGVuYWJsZSB0aGVtID8NCg0KVGhhbmsg
eW91IGZvciB0aGUgaGVscC4NCg0KQmVzdCByZWdhcmRzDQpKYWNrc29u

------=_NextPart_000_000B_01C7031B.70B07000
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI5NjMiIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+PEZPTlQgc2l6
ZT0yPjwvRk9OVD48QlI+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5IaSwgYWxsPC9GT05UPjwv
RElWPg0KPERJVj48Rk9OVCBzaXplPTI+SSBoYXZlIGJlZW4gY29uZnVzZWQgYnkgY2FjaGUgcmVj
ZW50bHkuPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+MS4gd2h5IG5lZWQgd2UgZGlz
YWJsZSBpY2FjaGUgYW5kIGRjYWNoZSBhdCB0aGUgYmVnaW5uaW5nIG9mIA0KdGhlIHUtYm9vdCBj
b2RlPzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjIuIHdoZW4gY2FuIHdlIGVuYWJs
ZSB0aGVtID88L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9E
SVY+DQo8RElWPjxGT05UIHNpemU9Mj5UaGFuayB5b3UgZm9yIHRoZSBoZWxwLjwvRk9OVD48L0RJ
Vj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6
ZT0yPkJlc3QgcmVnYXJkczwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPkphY2tzb248
L0ZPTlQ+PC9ESVY+PC9CT0RZPjwvSFRNTD4NCg==

------=_NextPart_000_000B_01C7031B.70B07000--
