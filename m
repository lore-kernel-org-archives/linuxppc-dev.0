Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 0AA68140134
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 20:14:59 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18177-01 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  2 May 2014 11:14:46 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexander Graf' <agraf@suse.de>, Mihai Caraman
 <mihai.caraman@freescale.com>
Subject: RE: [PATCH v2 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction
 for emulation
Date: Fri, 2 May 2014 10:12:51 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F705051@AcuExch.aculab.com>
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-5-git-send-email-mihai.caraman@freescale.com>
 <53636CFA.5050006@suse.de>
In-Reply-To: <53636CFA.5050006@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQWxleGFuZGVyIEdyYWYNCi4uLg0KPiA+ICsJcGFnZSA9IHBmbl90b19wYWdlKHBmbik7
DQo+ID4gKwllYWRkciA9ICh1bnNpZ25lZCBsb25nKWttYXBfYXRvbWljKHBhZ2UpOw0KPiA+ICsJ
ZWFkZHIgfD0gYWRkciAmIH5QQUdFX01BU0s7DQo+ID4gKwkqaW5zdHIgPSAqKHUzMiAqKWVhZGRy
Ow0KPiA+ICsJa3VubWFwX2F0b21pYygodTMyICopZWFkZHIpOw0KPiANCj4gSSB0aGluayBJJ2Qg
cmF0aGVyIHdyaXRlIHRoaXMgYXMNCj4gDQo+ICAgICppbnN0ciA9ICoodTMyICopKGVhZGRyIHwg
KGFkZHIgJiB+UEFHRSkpOw0KPiAgICBrdW5tYXBfYXRvbWljKCh2b2lkKillYWRkcik7DQo+IA0K
PiB0byBtYWtlIHN1cmUgd2UgcGFzcyB0aGUgdW5tYXAgZnVuY3Rpb24gdGhlIHNhbWUgdmFsdWUg
d2UgZ290IGZyb20gdGhlDQo+IG1hcCBmdW5jdGlvbi4NCj4gDQo+IE90aGVyd2lzZSBsb29rcyBn
b29kIHRvIG1lLg0KDQpJcyB0aGVyZSBhbnkgbWlsZWFnZSBpbiBrZWVwaW5nIGEgdmlydHVhbCBh
ZGRyZXNzIHBhZ2UgYWxsb2NhdGVkIChwZXIgY3B1KQ0KZm9yIHRoaXMgKGFuZCBzaW1pbGFyKSBh
Y2Nlc3NlcyB0byBwaHlzaWNhbCBtZW1vcnk/DQpOb3QgaGF2aW5nIHRvIHNlYXJjaCBmb3IgYSBm
cmVlIFZBIHBhZ2UgbWlnaHQgc3BlZWQgdGhpbmdzIHVwIChpZiB0aGF0IG1hdHRlcnMpLg0KDQpZ
b3UgYWxzbyBwcm9iYWJseSB3YW50IHRoZSBwYWdlIG1hcHBlZCB1bmNhY2hlZCAtIG5vIHBvaW50
IHBvbGx1dGluZyB0aGUgZGF0YQ0KY2FjaGUuDQoNCglEYXZpZA0KDQo=
