Return-Path: <vinayak.kale@gmail.com>
Received: from mail-vw0-f230.google.com (mail-vw0-f230.google.com
	[209.85.212.230]) by ozlabs.org (Postfix) with ESMTP id DBA82B7BBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 00:53:43 +1100 (EST)
Received: by vws19 with SMTP id 19so164913vws.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Dec 2009 05:53:41 -0800 (PST)
MIME-Version: 1.0
Message-ID: <0016363b7ec8d1ffb8047a37e663@google.com>
Date: Tue, 08 Dec 2009 13:53:41 +0000
Subject: DTS parsing and kernel bus support query
From: vinayak.kale@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016363b7ec8d1ff9c047a37e660
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016363b7ec8d1ff9c047a37e660
Content-Type: text/plain; charset=windows-1252; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkNCg0KSSBoYXZlIGZvbGxvd2luZyBxdWVyaWVzIGFib3V0IERUUyBwYXJzaW5nIGFuZCBrZXJu
ZWwgYnVzIHN1cHBvcnQuIEkgd291bGQgIA0KcmVhbGx5IGFwcHJlY2lhdGUgYW55IGhlbHAuDQoN
CkkgaGF2ZSBhIFBvd2VyUEMgNDQwIGNvcmUgYmFzZWQgYm9hcmQuIFdlIGFyZSBwb3J0aW5nIExp
bnV4IGtlcm5lbCCWIDIuNi4zMS4NCg0KMSkgRm9yIG90aGVyIFBvd2VyUEMgNHh4IGJhc2VkIGJv
YXJkcywgd2hhdCB3ZSBmb3VuZCBpcyBkZXZpY2VzIGxpa2UgIA0KVUFSVC9JMkMvR1BJTyBhcmUg
Y29ubmVjdGVkIHRocm91Z2ggUExCLT5PUEIgYnVzZXMuIEFjY29yZGluZ2x5IHdlIHNwZWNpZnkg
IA0KdGhlIG5vZGUgc3RydWN0dXJlIGluc2lkZSBhIGR0cyBmaWxlLiBEb2VzIGtlcm5lbCB1c2Vz
IHRoZSBhY3R1YWwgcGF0aCB0byAgDQpsb2NhdGUgYSBub2RlIGVnIC9wbGIvb3BiL2kyYz8gb3Ig
aXQgdXNlcyB0aGUgY29tcGF0aWJsZSBwcm9wZXJ0eSB0byBsb2NhdGUgIA0KYSBub2RlPw0KDQoy
KUluIGNhc2Ugb2Ygb3VyIGJvYXJkLCBpbnN0ZWFkIG9mIE9QQiBhbmQgRUJDIHdlIGhhdmUgYnVz
ZXMgbGlrZSBBSSBhbmQgIA0KQVBCLiBTbyBvdXIgRFRTIG5vZGUgc3RydWN0IGZvciBVQVJUIGxv
b2tzIGxpa2UgL3BsYi9haS9hcGIvc2VyaWFsLiBGb3IgIA0KdGhpcyBkbyB3ZSBuZWVkIHRvIGFk
ZCBhbnkgZXh0cmEgc3VwcG9ydCBpbiBrZXJuZWwgaW4gb3JkZXIgdG8gcmVjb2duaXplICANCnRo
ZSBkZXZpY2VzIG9uIEFJIGFuZCBBUEIgYnVzZXM/IFNpbWlsYXIgcXVlc3Rpb24gZm9yIEZsYXNo
IGRldmljZS4gSXQncyBvbiAgDQp0aGUgcGF0aCAvcGxiL2FpL2ZsYXNoLg0KSSBuZWVkIHRvIGFj
Y2VzcyBVQVJUL0kyQy9HUElPL0ZsYXNoIGRldmljZXMgb3ZlciBBSSBhbmQgQVBCIGJ1cy4gUExC
IGlzICANCmNvbm5lY3RlZCB0byBBSSBidXMuIEFJIGlzIGZ1cnRoZXIgY29ubmVjdGVkIHRvIEFQ
Qi4NCg0KMykgRG8gd2UgbmVlZCB0byBhZGQgZXh0cmEgc3VwcG9ydCBmb3IgQUkvQVBCIGJ1cyBp
biBrZXJuZWw/DQoNClRoYW5rcywNClZpbmF5YWsNCg==
--0016363b7ec8d1ff9c047a37e660
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi=20
<br />
<br />I have following queries about DTS parsing and kernel bus support. I =
would really appreciate any help.
<br />
<br />I have a PowerPC 440 core based board. We are porting Linux kernel =
=96 2.6.31.
<br />
<br />1) For other PowerPC 4xx based boards, what we found is devices like =
UART/I2C/GPIO are connected through PLB-&gt;OPB buses. Accordingly we speci=
fy the node structure inside a dts file. Does kernel uses the actual path t=
o locate a node e.g. /plb/opb/i2c? or it uses the compatible property to lo=
cate a node?
<br />
<br />2)In case of our board, instead of OPB and EBC we have buses like AI =
and APB. So our DTS node struct for UART looks like /plb/ai/apb/serial. For=
 this do we need to add any extra support in kernel in order to recognize t=
he devices on AI and APB buses? Similar question for Flash device. It=92s o=
n the path /plb/ai/flash.=20
<br />I need to access UART/I2C/GPIO/Flash devices over AI and APB bus. PLB=
 is connected to AI bus. AI is further connected to APB.
<br />
<br />3) Do we need to add extra support for AI/APB bus in kernel?
<br />
<br />Thanks,
<br />Vinayak
--0016363b7ec8d1ff9c047a37e660--
