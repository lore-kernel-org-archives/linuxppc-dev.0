Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ssL73FLzDr8d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:40:06 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sinan Kaya' <okaya@codeaurora.org>, Oliver <oohall@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: RFC on writel and writel_relaxed
Date: Wed, 21 Mar 2018 14:35:20 +0000
Message-ID: <8a13375fd8e5439890768b7dd8473099@AcuMS.aculab.com>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
In-Reply-To: <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiB4ODYgaGFzIGNvbXBpbGVyIGJhcnJpZXIgaW5zaWRlIHRoZSByZWxheGVkKCkgQVBJIHNvIHRo
YXQgY29kZSBkb2VzIG5vdA0KPiBnZXQgcmVvcmRlcmVkLiBBUk02NCBhcmNoaXRlY3R1cmFsbHkg
Z3VhcmFudGVlcyBkZXZpY2Ugd3JpdGVzIHRvIGJlIG9ic2VydmVkDQo+IGluIG9yZGVyLg0KDQpU
aGVyZSBhcmUgcGxhY2VzIHdoZXJlIHlvdSBkb24ndCBldmVuIG5lZWQgYSBjb21waWxlIGJhcnJp
ZXIgYmV0d2Vlbg0KZXZlcnkgd3JpdGUuDQoNCkkgaGFkIGhvcnJpZCBwcm9ibGVtcyBnZXR0aW5n
IHNvbWUgcHBjIGNvZGUgKGZvciBhIHNwZWNpZmljIGVtYmVkZGVkIFNvQykNCm9wdGltaXNlZCB0
byBoYXZlIG5vIGV4dHJhIGJhcnJpZXJzLg0KSSBlbmRlZCB1cCBqdXN0IHdyaXRpbmcgdGhyb3Vn
aCAncG9pbnRlciB0byB2b2xhdGlsZScgYW5kIGFkZGluZyBhbg0KZXhwbGljaXQgJ2VpZWlvJyBi
ZXR3ZWVuIHRoZSBibG9jayBvZiB3cml0ZXMgYW5kIHN0YXR1cyByZWFkLg0KDQpObyBsZXNzIHBh
aW5mdWwgd2FzIGRvaW5nIGEgYnl0ZXN3YXBwaW5nIHdyaXRlIHRvIG5vcm1hbCBtZW1vcnkuDQoN
CglEYXZpZA0KDQo=
