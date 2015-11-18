Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27D501A073D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 02:37:01 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cyril Bur' <cyrilbur@gmail.com>, "mikey@neuling.org" <mikey@neuling.org>,
 "anton@samba.org" <anton@samba.org>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH 0/8] FP/VEC/VSX switching optimisations
Date: Wed, 18 Nov 2015 14:51:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBD5633@AcuExch.aculab.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
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

RnJvbTogQ3lyaWwgQnVyDQo+IFNlbnQ6IDE4IE5vdmVtYmVyIDIwMTUgMDM6MjcNCi4uLg0KPiBU
aGUgZ29hbCBvZiB0aGVzZSBwYXRjaGVzIGlzIHRvIHJld29yayBob3cgdGhlICdtYXRoJyByZWdp
c3RlcnMgKEZQLCBWRUMNCj4gYW5kIFZTWCkgYXJlIGNvbnRleHQgc3dpdGNoZWQuIEN1cnJlbnRs
eSB0aGUga2VybmVsIGFkb3B0cyBhIGxhenkgYXBwcm9hY2gsDQo+IGFsd2F5cyBzd2l0Y2hpbmcg
dXNlcnNwYWNlIHRhc2tzIHdpdGggYWxsIHRocmVlIGZhY2lsaXRpZXMgZGlzYWJsZWQgYW5kDQo+
IGxvYWRzIGluIGVhY2ggc2V0IG9mIHJlZ2lzdGVycyB1cG9uIHJlY2VpdmluZyBlYWNoIHVuYXZh
aWxhYmxlIGV4Y2VwdGlvbi4NCj4gVGhlIGtlcm5lbCBkb2VzIHRyeSB0byBhdm9pZCBkaXNhYmxp
bmcgdGhlIGZlYXR1cmVzIGluIHRoZSBzeXNjYWxsIHF1aWNrDQo+IHBhdGggYnV0IGl0IGR1cmlu
ZyB0ZXN0aW5nIGl0IGFwcGVhcnMgdGhhdCBldmVuIHdoYXQgc2hvdWxkIGJlIGEgc2ltcGxlDQo+
IHN5c2NhbGwgc3RpbGwgY2F1c2VzIHRoZSBrZXJuZWwgdG8gdXNlIHNvbWUgZmFjaWxpdGllcyAo
dmVjdG9yaXNlZCBtZW1jcHkNCj4gZm9yIGV4YW1wbGUpIGZvciBpdHMgc2VsZiBhbmQgdGhlcmVm
b3JlIGRpc2FibGUgaXQgZm9yIHRoZSB1c2VyIHRhc2suDQoNClBlcmhhcHMgdGhlIGtlcm5lbCBz
aG91bGQgYmUgYXZvaWRpbmcgdXNpbmcgdGhlc2UgcmVnaXN0ZXJzPw0KSSB3b25kZXIgaWYgdGhl
IGdhaW4gZnJvbSB1c2luZyB2ZWN0b3Jpc2VkIG1lbWNweSBpcyB0eXBpY2FsbHkNCmVub3VnaCB0
byB3YXJyYW50IHRoZSBjb3N0IG9mIHRoZSBzYXZlIGFuZCByZXN0b3JlPw0KDQpUaGVyZSBtYXkg
ZXZlbiBiZSBzY29wZSBmb3Iga2VybmVsIGNvZGUgZG9pbmcgYSBzYXZlL3Jlc3RvcmUNCm9mIGEg
c21hbGwgbnVtYmVyIG9mIHJlZ2lzdGVycyBvbnRvIGFuIGluLXN0YWNrIHNhdmUgYXJlYS4NCkl0
IHdvdWxkIG5lZWQgdG8gYmUgbGlua2VkIHRvIHRoZSBkYXRhIG9mIHRoZSB0aHJlYWQNCnRoYXQg
b3ducyB0aGUgZnB1IHJlZ2lzdGVycyBzbyB0aGF0IGEgc2F2ZSByZXF1ZXN0IGNvdWxkDQpiZSBo
b25vdXJlZC4NClByZS1lbXB0aW9uIHdvdWxkIHByb2JhYmx5IG5lZWQgdG8gYmUgZGlzYWJsZWQs
IGJ1dCBuZXN0ZWQNCnVzZSwgYW5kIHVzZSBmcm9tIElTUiBzaG91bGQgYmUgb2suDQoNCglEYXZp
ZA0KDQo=
