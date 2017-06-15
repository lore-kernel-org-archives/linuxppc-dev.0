Return-Path: <Frank.Rowand@sony.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0120.outbound.protection.outlook.com [104.47.40.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpVKk5PvSzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:07:06 +1000 (AEST)
From: "Rowand, Frank" <Frank.Rowand@sony.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
CC: sachinp <sachinp@linux.vnet.ibm.com>, linux-next
 <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mpe <mpe@ellerman.id.au>
Subject: RE: [Oops][next-20170614][] powerpc boot fails with WARNING: CPU:
 12 PID: 0 at mm/memblock.c
Date: Thu, 15 Jun 2017 17:06:56 +0000
Message-ID: <ED290C750E1B324E972B0017C9D4BAB02E5A7EAF@USCULXMSG03.am.sony.com>
References: <1497506437.15415.60.camel@abdul.in.ibm.com>
 <1497518696.15415.68.camel@abdul.in.ibm.com>
In-Reply-To: <1497518696.15415.68.camel@abdul.in.ibm.com>
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

T24gVGh1cnNkYXksIEp1bmUgMTUsIDIwMTcgMjoyNSBBTSwgQWJkdWwgSGFsZWVtIFttYWlsdG86
YWJkaGFsZWVAbGludXgudm5ldC5pYm0uY29tXSAgd3JvdGU6DQo+DQo+IE9uIFRodSwgMjAxNy0w
Ni0xNSBhdCAxMTozMCArMDUzMCwgQWJkdWwgSGFsZWVtIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4g
bGludXgtbmV4dCBmYWlscyB0byBib290IG9uIHBvd2VycGMgQmFyZS1tZXRhbCB3aXRoIHRoZXNl
IHdhcm5pbmdzLg0KPj4NCj4+IG1hY2hpbmUgYm9vdGVkIGZpbmUgb24gbmV4dC0yMDE3MDYxMw0K
Pg0KPiBUaGFua3MgTWljaGFlbCwgWWVzIGl0IGlzICg3NWZlMDRlNTkgb2Y6IHJlbW92ZSAqcGhh
bmRsZSBwcm9wZXJ0aWVzIGZyb20NCj4gZXhwYW5kZWQgZGV2aWNlIHRyZWUpDQo+DQo+IEZyYW5r
LCB3b3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSB0cmFjZS4NCj4NCj4gVGhhbmtz
DQoNCjwgc25pcCA+DQoNCk15IHBhdGNoIHNlcmllcyAnb2Y6IHJlbW92ZSAqcGhhbmRsZSBwcm9w
ZXJ0aWVzIGZyb20gZXhwYW5kZWQgZGV2aWNlIHRyZWUnDQppbiAtbmV4dCBzZWVtcyB0byBoYXZl
IGJyb2tlbiBib290IGZvciBhIHNpZ25pZmljYW50IG51bWJlciBvZiBwb3dlcnBjDQpzeXN0ZW1z
LiAgSSBhbSBhY3RpdmVseSB3b3JraW5nIG9uIHVuZGVyc3RhbmRpbmcgYW5kIGZpeGluZyB0aGUg
cHJvYmxlbS4NCg0KLUZyYW5rDQo=
