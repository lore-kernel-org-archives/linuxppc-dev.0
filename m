Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 31AF467A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 01:42:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Date: Tue, 1 Feb 2005 08:41:58 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592AC@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 8266 SMC uart corruption
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SGkNCg0KSGFzIGFueWJvcmR5IGVsc2Ugc2VlbiBjb3JydXB0aW9uIG9mIHRoZSBvdXRwdXQgZnJv
bSBTTUMxIHdoZW4gdXNlZCBhcyBzZXJpYWwgY29uc29sZT8NClRoaXMgb25seSBvY2N1cnMgaW4g
aW4gMi42LjggYW5kIGxhdGVyICh3aGVuIHRoZSBDUE0gc2VyaWFsIGRyaXZlcnMgZ290IG1vdmVk
KQ0KQW5kIGl0IG9ubHkgb2NjdXJzIHdoZW4gaW5pdCBpcyB3cml0aW5nIHRvIHNjcmVlbi4gMi42
LjcgYW5kIGVhcmxpZXIgd29ya3MgcGVyZmVjdGx5Lg0KSXQgaGFwcGVucyBhdCBhbGwgYmF1ZHJh
dGVzIHRlc3RlZCAoOTYwMCBhbmQgMTE1MjAwKQ0KDQpBbnlib2R5IHNlZW4gc29tZXRoaW5nIHNp
bWlsYXIgYW5kL29yIGhhdmUgYSBjbHVlIHdoZXJlIHRvIHN0YXJ0IGxvb2tpbmcgZm9yIHRoaXM/
DQpJIGhhdmUgbG9va2VkIGF0IHRoZSBzZXJpYWwgZHJpdmVycywgYW5kIGNhbm5vdCBmaW5kIGFu
eSBkaWZmZXJlbmNlcyBsYXJnZSBkaWZmZXJlbmNlcyBmcm9tIHdoZW50aGV5IHN0aWxsIHdlcmUg
aW4gYXJjaC9wcGMvODI2MF9pbyB0byB0aGUgb25lcyBpbiBkcml2ZXJzL3NlcmlhbC9jcG1fdWFy
dA0KDQpDYXB0dXJlOg0KDQpGcmVlaW5nIHVudXNlZCBrZXJuZWwgbWVtb3J5OiAyODhrIGnOtXQN
CknilqBUOiB2ZXJzaW9uIDIuODUgYm9vdOKImWcNCi4uLg0KSeKWoFTCoEVudGVyaW5nIHJ1bmxl
dmVsOiAzDQoNCg0KVGhlc2UgbGluZXMgYXJlIHRoZSBvbmx5IG9uZXMgdGhhdCBnZXQgY29ycnVw
dGVkLiBBbGwgb3RoZXIgb3V0cHV0IChrZXJuZWwgcHJpbnRvdXRzLCBjb25zb2xlIGFuZCBzdGFy
dHVwIHNjcmlwdHMpIGFyZSBub3JtYWwuDQoNClJ1bmUgVG9yZ2Vyc2VuDQpTeXN0ZW0gRGV2ZWxv
cGVyDQpJbm5vdmF0aXZlIFN5c3RlbXMgTExDDQoxMDAwIElubm92YXRpdmUgRHJpdmUNCk1pdGNo
ZWxsLCBTRCA1NzMwMQ0KUGg6IDYwNS05OTUtNjEyMA0Kd3d3Lmlubm92c3lzLmNvbQ0K
