Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20D1D1A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 04:17:16 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'yalin wang' <yalin.wang2010@gmail.com>, Petr Mladek <pmladek@suse.com>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, Ingo Molnar <mingo@redhat.com>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Russell King
 <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Date: Wed, 2 Dec 2015 16:20:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
In-Reply-To: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
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

RnJvbTogeWFsaW4gd2FuZw0KPiBTZW50OiAzMCBOb3ZlbWJlciAyMDE1IDE2OjQyDQo+ID4gT24g
Tm92IDI3LCAyMDE1LCBhdCAxOTowOSwgUGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gVGVzdGluZyBoYXMgc2hvd24gdGhhdCB0aGUgYmFja3RyYWNlIHNvbWV0
aW1lcyBkb2VzIG5vdCBmaXQNCj4gPiBpbnRvIHRoZSA0a0IgdGVtcG9yYXJ5IGJ1ZmZlciB0aGF0
IGlzIHVzZWQgaW4gTk1JIGNvbnRleHQuDQo+ID4NCj4gPiBUaGUgd2FybmluZ3MgYXJlIGdvbmUg
d2hlbiBJIGRvdWJsZSB0aGUgdGVtcG9yYXJ5IGJ1ZmZlciBzaXplLg0KDQpZb3UgYXJlIHdhc3Rp
bmcgYSBsb3Qgb2YgbWVtb3J5IGZvciBzb21ldGhpbmcgdGhhdCBpcyBpbmZyZXF1ZW50bHkgdXNl
ZC4NClRoZXJlIG91Z2h0IHRvIGJlIHNvbWUgd2F5IG9mIGNvcHlpbmcgcGFydGlhbCB0cmFjZWJh
Y2tzIGludG8gdGhlDQptYWluIGJ1ZmZlci4NCg0KCURhdmlkDQoNCg==
