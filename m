Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v498r40Y1zDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:01:16 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ard Biesheuvel' <ard.biesheuvel@linaro.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
CC: Jessica Yu <jeyu@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Suzuki K.
 Poulose" <suzuki.poulose@arm.com>, Rusty Russell <rusty@rustcorp.com.au>,
 Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v4 3/3] modversions: treat symbol CRCs as 32 bit
 quantities on 64 bit archs
Date: Thu, 19 Jan 2017 17:01:05 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB026817E@AcuExch.aculab.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
 <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
 <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
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

RnJvbTogIEFyZCBCaWVzaGV1dmVsDQo+IFNlbnQ6IDE4IEphbnVhcnkgMjAxNyAxMzo1Mw0KLi4N
Cj4gSXQgdHVybnMgb3V0IHRoYXQgdGhpcyBvZGQgdHJlYXRtZW50IG9mIGFic29sdXRlIHN5bWJv
bHMgKGkuZS4sDQo+IHN5bWJvbHMgaGF2aW5nIHNlY3Rpb24gbnVtYmVyIFNITl9BQlMpIGlzIGEg
a25vd24gaXNzdWUgaW4gR05VIGxkDQo+IA0KPiBodHRwczovL3NvdXJjZXdhcmUub3JnL21sL2Jp
bnV0aWxzLzIwMTItMDUvbXNnMDAwMTkuaHRtbA0KLi4uDQoNCkplZXBlcnMgLSB0aGF0IGlzIHRy
dWx5IGYqY2tlZC4NCg0KSSd2ZSBldmVuIHVzZWQgdGhlIGxpbmtlciBzY3JpcHQgdG8gZ2VuZXJh
dGUgYWJzb2x1dGUgc3ltYm9scyBmb3IgdGhlDQpzaXplcyBvZiBpdGVtcyAtIHRoZXkgcmVhbGx5
IGRvbid0IHdhbnQgcmVsb2NhdGluZyAoZXZlcikuDQoNCklmIHlvdSBnbyBiYWNrIHRvIChzYXkp
IFJTWDExL00gbG9hZHMgb2YgdGhlIGNvbnN0YW50cyAobGlrZSBzeXN0ZW0NCmNhbGwgbnVtYmVy
cyBhbmQgc3RydWN0dXJlIG9mZnNldHMpIHdvdWxkIGJlIHN1cHBsaWVkIGJ5IHRoZSBsaW5rZXIN
CmlmIHRoZSBhc3NlbWJsZXIgZGlkbid0IGtub3cgdGhlIHZhbHVlLg0KVGhhdCBsaW5rZXIgc3Vw
cG9ydGVkIChtb3JlIG9yIGxlc3MpIGFyYml0cmFyeSBleHByZXNzaW9ucyBpbiBmaXh1cHMuDQoN
CglEYXZpZA0KDQo=
