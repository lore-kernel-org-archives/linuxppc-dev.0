Return-Path: <benny@cellvision.com.cn>
Received: from out01.east.net (unknown [202.130.225.2])
	by ozlabs.org (Postfix) with ESMTP id 582B82BDB5
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jan 2005 00:34:56 +1100 (EST)
Received: from unknown (HELO smtp01.east.net) ([202.130.225.4])
	(envelope-sender <benny@cellvision.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 1 Jan 2005 21:12:11 +0800
Received: from unknown (HELO BENNY)
	(Authenticated?user:?benny@cellvision.com.cn@[202.108.158.65])
	(envelope-sender <benny@cellvision.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 1 Jan 2005 21:41:08 +0800
Message-ID: <008c01c4f005$bc1e94c0$1100a8c0@BENNY>
From: "Benny Liu" <benny@cellvision.com.cn>
To: <linuxppc-dev@ozlabs.org>
Date: Sat, 1 Jan 2005 21:28:09 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0089_01C4F048.CA2A0700"
Subject: isochronous mode of USB audio device on MPC5200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0089_01C4F048.CA2A0700
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGksIGV2ZXJ5b25lLCBoYXBweSBuZXcgeWVhciENCg0KRGlkIGFueW9uZSB0cnkgdXNiIGF1ZGlv
IGRldmljZSBvciBvdGhlciBpc29jaHJvbm91cyBtb2RlIHVzYiBkZXZpY2VzIG9uIEljZWN1YmUg
Ym9hcmQoTW90b3JvbGEgTVBDNTIwMCk/DQoNCkkgdHJpZWQsIGJ1dCBpdCByZXBvcnRzIHRoZSBm
b2xsb3dpbmcgbWVzc2FnZToNCg0KImhvc3QvdXNiLW9oY2kuYzogT0hDSSBVbnJlY292ZXJhYmxl
IEVycm9yLCBjb250cm9sbGVyIHVzYi0wIGRpc2FibGVkIg0KDQpBZnRlciB0aGlzIG1lc3NhZ2Us
IHRoZSBob3N0IGNvbnRyb2xsZXIgaXMgZGlzYWJsZWQuDQoNClRoYW5rcyBhIGxvdC4=

------=_NextPart_000_0089_01C4F048.CA2A0700
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI1MjMiIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj4NCjxESVY+PEZPTlQgc2l6
ZT0yPkhpLCBldmVyeW9uZSwgaGFwcHkgbmV3IHllYXIhPC9GT05UPjwvRElWPg0KPERJVj48Rk9O
VCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+RGlkIGFueW9u
ZSB0cnkmbmJzcDt1c2IgYXVkaW8gZGV2aWNlIG9yIG90aGVyIGlzb2Nocm9ub3VzIG1vZGUgDQp1
c2IgZGV2aWNlcyBvbiBJY2VjdWJlIGJvYXJkKE1vdG9yb2xhIE1QQzUyMDApPzwvRk9OVD48L0RJ
Vj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6
ZT0yPkkgdHJpZWQsIGJ1dCBpdCByZXBvcnRzIHRoZSBmb2xsb3dpbmcgbWVzc2FnZTo8L0ZPTlQ+
PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJz
cDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjxFTT4iaG9zdC91c2Itb2hjaS5jOiBPSENJIFVu
cmVjb3ZlcmFibGUgRXJyb3IsIGNvbnRyb2xsZXIgDQp1c2ItMCBkaXNhYmxlZCI8L0VNPjwvRk9O
VD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZP
TlQgc2l6ZT0yPkFmdGVyIHRoaXMmbmJzcDttZXNzYWdlLCB0aGUgaG9zdCBjb250cm9sbGVyIGlz
IA0KZGlzYWJsZWQuPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+PC9GT05UPiZuYnNw
OzwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+VGhhbmtzIGEgbG90LjwvRk9OVD48L0RJVj48L0ZP
TlQ+PC9ESVY+PC9CT0RZPjwvSFRNTD4NCg==

------=_NextPart_000_0089_01C4F048.CA2A0700--
