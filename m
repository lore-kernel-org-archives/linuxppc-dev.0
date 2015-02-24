Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECA0B1A12F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:57:18 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ingo Molnar' <mingo@kernel.org>, Anton Blanchard <anton@samba.org>
Subject: RE: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
Date: Tue, 24 Feb 2015 09:56:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAE9BD3@AcuExch.aculab.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <1424748634-9153-2-git-send-email-anton@samba.org>
 <20150224064107.GB15387@gmail.com>
In-Reply-To: <20150224064107.GB15387@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Don Zickus <dzickus@redhat.com>, Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "sam.bobroff@au1.ibm.com" <sam.bobroff@au1.ibm.com>,
 "hpa@zytor.com" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linus
 Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogSW5nbyBNb2xuYXINCi4uLg0KPiBTbyB3aHkgbm90IHRyeWxvY2sgYW5kIHRpbWUgb3V0
IGhlcmUgYWZ0ZXIgYSBmZXcgc2Vjb25kcywNCj4gaW5zdGVhZCBvZiBpbmRlZmluaXRlbHkgc3Vw
cmVzc2luZyBzb21lIHBvdGVudGlhbGx5IHZpdGFsDQo+IG91dHB1dCBkdWUgdG8gc29tZSBvdGhl
ciBDUFUgY3Jhc2hpbmcvbG9ja2luZyB3aXRoIHRoZSBsb2NrDQo+IGhlbGQ/DQoNCkkndmUgdXNl
ZCB0aGF0IGZvciBzdGF0dXMgcmVxdWVzdHMgdGhhdCB1c3VhbGx5IGxvY2sgYSB0YWJsZQ0KdG8g
Z2V0IGEgY29uc2lzdGVudCB2aWV3Lg0KSWYgdHJ5bG9jayB0aW1lcyBvdXQgYXNzdW1lIHRoYXQg
dGhlIGRhdGEgaXMgYWN0dWFsbHkgc3RhYmxlDQphbmQgYWNjZXNzIGl0IGFueXdheS4gUmVtZW1i
ZXIgdGhlIHBpZCBkb2luZyB0aGUgYWNjZXNzIGFuZA0KbmV4dCB0aW1lIGl0IHRyaWVzIHRvIGFj
cXVpcmUgdGhlIHNhbWUgbG9jayBkbyBhIHRyeWxvY2sgd2l0aA0Kbm8gdGltZW91dC4NClRoYXQg
d2F5IGlmICh3aGVuKSB0aGVyZSBpcyBhIGxvY2tpbmcgZnViYXIgKG9yIGEgZHJpdmVyIG9vcHMN
CndpdGggYSBsb2NrIGhlbGQpIGF0IGxlYXN0IHNvbWUgb2YgdGhlIHJlbGV2YW50IHN0YXR1cyBj
b21tYW5kcw0Kd2lsbCB3b3JrLg0KDQoJRGF2aWQNCg0K
