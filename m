Return-Path: <srs0=puwa=bw=aculab.com=david.laight@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL9bM6ZYTzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 20:10:07 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yL9bM62cRz8vl6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 20:10:07 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Neuling' <mikey@neuling.org>, 'Breno Leitao' <leitao@debian.org>,
 Michael Ellerman <mpe@ellerman.id.au>
CC: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "cyrilbur@gmail.com"
 <cyrilbur@gmail.com>
Subject: RE: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
Date: Mon, 23 Oct 2017 09:01:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009F052@AcuExch.aculab.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009D7D7@AcuExch.aculab.com>
 <1508547615.23934.6.camel@neuling.org>
In-Reply-To: <1508547615.23934.6.camel@neuling.org>
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

RnJvbTogTWljaGFlbCBOZXVsaW5nDQo+IFNlbnQ6IDIxIE9jdG9iZXIgMjAxNyAwMjowMA0KPiBU
bzogRGF2aWQgTGFpZ2h0OyAnQnJlbm8gTGVpdGFvJzsgTWljaGFlbCBFbGxlcm1hbg0KPiBDYzog
c3Rld2FydEBsaW51eC52bmV0LmlibS5jb207IGxpbnV4cHBjLWRldkBvemxhYnMub3JnOyBjeXJp
bGJ1ckBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIHBvd2VycGMvdG06IEFk
ZCBjb21tYW5kbGluZSBvcHRpb24gdG8gZGlzYWJsZSBoYXJkd2FyZSB0cmFuc2FjdGlvbmFsIG1l
bW9yeQ0KPiANCj4gT24gRnJpLCAyMDE3LTEwLTIwIGF0IDEyOjU4ICswMDAwLCBEYXZpZCBMYWln
aHQgd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIHNpbXBsZSBjb21tYW5kbGluZSBv
cHRpb24gc28gdGhhdCBIVE0gY2FuIGJlDQo+ID4gPiA+IGRpc2FibGVkIGF0IGJvb3QgdGltZS4N
Cj4gPg0KPiA+IElTVE0gdGhhdCBiZWluZyBhYmxlIHRvIGRpc2FibGUgaXQgYWZ0ZXIgYm9vdCB3
b3VsZCBiZSBtb3JlIHVzZWZ1bC4NCj4gPiAoaWUgaW4gYSBzdGFydHVwIHNjcmlwdCkNCj4gDQo+
IEkgYWdyZWUgYnVnIHVuZm9ydHVuYXRlbHkgdGhhdCdzIGltcG9zc2libGUuDQo+IA0KPiBJZiBh
IHByb2Nlc3MgaXMgYWxyZWFkeSBydW5uaW5nIGluIHRtIHN1c3BlbmQsIHRoZXJlIGlzIG5vIHdh
eSB0byBzdG9wIGl0IG90aGVyDQo+IHRoYW4ga2lsbGluZyB0aGUgcHJvY2Vzcy4gIEF0IHRoYXQg
cG9pbnQgeW91IG1heSBhcyB3ZWxsIGtleGVjIHdpdGggYSBuZXcNCj4gY21kbGluZSBvcHRpb24N
Cg0KSXNuJ3QgdGhhdCB1bmxpa2VseSB3aGVuIHRoZSBmaXJzdCByYyBzY3JpcHRzIGFyZSBiZWlu
ZyBydW4/DQpTZXR0aW5nIGFuIGVhcmx5IHJjIHNjcmlwdCBpcyBnZW5lcmFsbHkgZWFzaWVyIHRo
YW4gYWRkaW5nIGEgY29tbWFuZCBsaW5lDQpwYXJhbWV0ZXIuDQoNCkkgZG9uJ3Qga25vdyBhYm91
dCBwcGMsIGJ1dCBncnViIG9uIHg4NiBtYWtlcyBpdCBwYWluZnVsbHkgYWxtb3N0DQppbXBvc3Np
YmxlIHRvIGhhdmUgdHdvIGJvb3QgZW50cmllcyB0aGF0IGhhdmUgZGlmZmVyZW50IGNvbW1hbmQg
bGluZQ0Kb3B0aW9ucy4NCg0KCURhdmlkDQoNCg==
