Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 21E991A01E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 18:25:48 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27777-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 16 Jul 2014 09:25:36 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gavin Shan' <gwshan@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/6] powerpc/eeh: Refactor EEH flag accessors
Date: Wed, 16 Jul 2014 08:24:49 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1727472B@AcuExch.aculab.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1405489819-26211-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-2-git-send-email-gwshan@linux.vnet.ibm.com>
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

RnJvbTogR2F2aW4gU2hhbg0KPiBUaGVyZSBhcmUgbXVsdGlwbGUgZ2xvYmFsIEVFSCBmbGFncy4g
QWxtb3N0IGVhY2ggZmxhZyBoYXMgaXRzIG93bg0KPiBhY2Nlc3Nvciwgd2hpY2ggZG9lc24ndCBt
YWtlIHNlbnNlLiBUaGUgcGF0Y2ggcmVmYWN0b3JzIEVFSCBmbGFnDQo+IGFjY2Vzc29ycyBzbyB0
aGF0IHRoZXkgbG9vayB1bmlmaWVkOg0KPiANCj4gICBlZWhfYWRkX2ZsYWcoKTogICBBZGQgRUVI
IGZsYWcNCg0KZWVoX3NldF9mbGFnKCkgPz8NCg0KPiAgIGVlaF9jbGVhcl9mbGFnKCk6IENsZWFy
IEVFSCBmbGFnDQo+ICAgZWVoX2hhc19mbGFnKCk6ICAgQ2hlY2sgaWYgb25lIHNwZWNpZmljIGZs
YWcgaGFzIGJlZW4gc2V0DQoNClBlcnNvbmFsbHkgSSBmaW5kIHRoZXNlIHNvcnQgb2YgJ2FjY2Vz
c29yJyBmdW5jdGlvbnMgcmF0aGVyIHBvaW50bGVzcy4NCg0KCURhdmlkDQoNCg==
