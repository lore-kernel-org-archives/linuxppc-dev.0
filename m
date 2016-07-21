Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwGYH3Hz1zDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 00:36:01 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <nicholas.piggin@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH 05/14] powerpc/pseries: 4GB exception handler offsets
Date: Thu, 21 Jul 2016 14:34:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50086C@AcuExch.aculab.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
 <1469083453-9279-6-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-6-git-send-email-npiggin@gmail.com>
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

RnJvbTogTmljaG9sYXMgUGlnZ2luDQo+IFNlbnQ6IDIxIEp1bHkgMjAxNiAwNzo0NA0KLi4uDQo+
IEBAIC03MzksNyArNzM5LDggQEAga3ZtcHBjX3NraXBfSGludGVycnVwdDoNCj4gICAqIEVuc3Vy
ZSB0aGF0IGFueSBoYW5kbGVycyB0aGF0IGdldCBpbnZva2VkIGZyb20gdGhlIGV4Y2VwdGlvbiBw
cm9sb2dzDQo+ICAgKiBhYm92ZSBhcmUgYmVsb3cgdGhlIGZpcnN0IDY0S0IgKDB4MTAwMDApIG9m
IHRoZSBrZXJuZWwgaW1hZ2UgYmVjYXVzZQ0KPiAgICogdGhlIHByb2xvZ3MgYXNzZW1ibGUgdGhl
IGFkZHJlc3NlcyBvZiB0aGVzZSBoYW5kbGVycyB1c2luZyB0aGUNCj4gLSAqIExPQURfSEFORExF
UiBtYWNybywgd2hpY2ggdXNlcyBhbiBvcmkgaW5zdHJ1Y3Rpb24uDQo+ICsgKiBMT0FEX0hBTkRM
RVJfNEcgbWFjcm8sIHdoaWNoIHVzZXMgYW4gb3JpIGluc3RydWN0aW9uLiBDYXJlIG11c3QgYWxz
bw0KPiArICogYmUgdGFrZW4gYmVjYXVzZSByZWxhdGl2ZSBicmFuY2hlcyBjYW4gb25seSBhZGRy
ZXNzIDMySyBpbiBlYWNoIGRpcmVjdGlvbi4NCj4gICAqLw0KDQpUaGF0IGNvbW1lbnQgbm93IGxv
b2tzIHdyb25nLg0KDQoJRGF2aWQNCg0K
