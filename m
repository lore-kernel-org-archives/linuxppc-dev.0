Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 8EF541A0297
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 00:40:48 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 01337-02 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 24 Jun 2014 15:40:36 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexey Kardashevskiy' <aik@ozlabs.ru>, Alex Williamson
 <alex.williamson@redhat.com>, Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH] vfio: Fix endianness handling for emulated BARs
Date: Tue, 24 Jun 2014 14:40:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17263229@AcuExch.aculab.com>
References: <1403091391-31780-1-git-send-email-aik@ozlabs.ru>
 <1403116512.3707.175.camel@ul30vt.home> <53A233E9.6030006@ozlabs.ru>
 <53A241F6.9010307@ozlabs.ru> <53A25D74.5000804@ozlabs.ru>
 <1403234514.3707.278.camel@ul30vt.home> <1403305961.4587.66.camel@pasglop>
 <53A94EBD.101@ozlabs.ru> <53A955F5.6050801@suse.de>
 <53A9741B.1040500@ozlabs.ru> <53A97486.4070604@suse.de>
 <53A976B7.3070709@ozlabs.ru> <53A97BA9.4020702@suse.de>
 <1403619685.16078.15.camel@ul30vt.home> <53A98C38.8020205@ozlabs.ru>
In-Reply-To: <53A98C38.8020205@ozlabs.ru>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQWxleGV5IEthcmRhc2hldnNraXkNCi4uLg0KPiA+PiBTbyBJTUhPIHdlIHNob3VsZCBl
aXRoZXIgY3JlYXRlIG5ldywgZ2VuZXJpYyBpb3dyaXRlIGhlbHBlcnMgdGhhdCBkb24ndA0KPiA+
PiBkbyBhbnkgZW5kaWFuIHN3YXBwaW5nIGF0IGFsbCBvciBkbyBpb3dyaXRlMzIoY3B1X3RvX2xl
MzIodmFsKSkgY2FsbHMuDQo+ID4NCj4gPiBJJ20gb25lIG9mIHRob3NlIHBlb3BsZSBmb3Igd2hv
bSBpb3dyaXRlMzIobGUzMl90b19jcHUodmFsKSkgbWFrZXMgc2Vuc2UNCj4gDQo+IA0KPiBJIGRv
IG5vdCB1bmRlcnN0YW5kIHdoeSBAdmFsIGlzIGNvbnNpZGVyZWQgTEUgaGVyZSBhbmQgbmVlZCB0
byBiZSBjb252ZXJ0ZWQNCj4gdG8gQ1BVLiBSZWFsbHkuIEkgdHJ1bHkgYmVsaWV2ZSBpdCBzaG91
bGQgYmUgY3B1X3RvX2xlMzIoKS4NCg0KVGhpbmsgYWJvdXQgaXQgY2FyZWZ1bGx5Li4uDQoNCkFw
cGFyZW50bHkgaW93cml0ZTMyKCkgaXMgd3JpdGluZyBhICdjcHUnIHZhbHVlIG91dCAnbGUnLg0K
U28gaWYgeW91IGhhdmUgYSAnbGUnIHZhbHVlIHlvdSBuZWVkIHRvIGNvbnZlcnQgaXQgdG8gJ2Nw
dScgZmlyc3QuDQoNCkkgcmVhbGx5IHdvbid0IGFzayBob3cgJ2JlJyBwcGMgbWFuYWdlZCB0byBn
ZXQgJ2xlJyBvbi1jaGlwIHBlcmlwaGVyYWxzLg0KDQoJRGF2aWQNCg0K
