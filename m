Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRZfP1X6BzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 23:16:10 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pasha Tatashin' <pasha.tatashin@oracle.com>, Will Deacon
 <will.deacon@arm.com>
CC: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "sam@ravnborg.org"
 <sam@ravnborg.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "x86@kernel.org"
 <x86@kernel.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "willy@infradead.org" <willy@infradead.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Date: Tue, 8 Aug 2017 13:15:55 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
In-Reply-To: <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
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

RnJvbTogUGFzaGEgVGF0YXNoaW4NCj4gU2VudDogMDggQXVndXN0IDIwMTcgMTI6NDkNCj4gVGhh
bmsgeW91IGZvciBsb29raW5nIGF0IHRoaXMgY2hhbmdlLiBXaGF0IHlvdSBkZXNjcmliZWQgd2Fz
IGluIG15DQo+IHByZXZpb3VzIGl0ZXJhdGlvbnMgb2YgdGhpcyBwcm9qZWN0Lg0KPiANCj4gU2Vl
IGZvciBleGFtcGxlIGhlcmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3LzUvNS8zNjkNCj4g
DQo+IEkgd2FzIGFza2VkIHRvIHJlbW92ZSB0aGF0IGZsYWcsIGFuZCBvbmx5IHplcm8gbWVtb3J5
IGluIHBsYWNlIHdoZW4NCj4gbmVlZGVkLiBPdmVyYWxsIHRoZSBjdXJyZW50IGFwcHJvYWNoIGlz
IGJldHRlciBldmVyeXdoZXJlIGVsc2UgaW4gdGhlDQo+IGtlcm5lbCwgYnV0IGl0IGFkZHMgYSBs
aXR0bGUgZXh0cmEgY29kZSB0byBrYXNhbiBpbml0aWFsaXphdGlvbi4NCg0KUGVyaGFwcyB5b3Ug
Y291bGQgI2RlZmluZSB0aGUgZnVuY3Rpb24gcHJvdG90eXBlKHM/KSBzbyB0aGF0IHRoZSBmbGFn
cw0KYXJlIG5vdCBwYXNzZWQgdW5sZXNzIGl0IGlzIGEga2FzYW4gYnVpbGQ/DQoNCglEYXZpZA0K
DQo=
