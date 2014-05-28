Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 3472A1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 18:46:55 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18587-03 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 28 May 2014 09:46:42 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cody P Schafer' <dev@codyps.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 11/16] byteorder: provide a linux/byteorder.h with {be,
 le}_to_cpu() and cpu_to_{be, le}() macros
Date: Wed, 28 May 2014 08:45:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1724EEAF@AcuExch.aculab.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
In-Reply-To: <1401236684-10579-12-git-send-email-dev@codyps.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQ29keSBQIFNjaGFmZXINCj4gUmF0aGVyIG1hbnVhbGx5IHNwZWNpZnlpbmcgdGhlIHNp
emUgb2YgdGhlIGludGVnZXIgdG8gYmUgY29udmVydGVkLCBrZXkNCj4gb2ZmIG9mIHRoZSB0eXBl
IHNpemUuIFJlZHVjZXMgZHVwbGljYXRlIHNpemUgaW5mbyBhbmQgdGhlIG9jY3VyYW5jZSBvZg0K
PiBjZXJ0YWluIHR5cGVzIG9mIGJ1Z3MgKHVzaW5nIHRoZSB3cm9uZyBzaXplZCBjb252ZXJzaW9u
KS4NCi4uLg0KPiArI2RlZmluZSBiZV90b19jcHUodikgXA0KPiArCV9fYnVpbHRpbl9jaG9vc2Vf
ZXhwcihzaXplb2YodikgPT0gc2l6ZW9mKHVpbnQ4X3QpICwgdiwJXA0KPiArCV9fYnVpbHRpbl9j
aG9vc2VfZXhwcihzaXplb2YodikgPT0gc2l6ZW9mKHVpbnQxNl90KSwgYmUxNl90b19jcHUodiks
IFwNCj4gKwlfX2J1aWx0aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKHYpID09IHNpemVvZih1aW50MzJf
dCksIGJlMzJfdG9fY3B1KHYpLCBcDQo+ICsJX19idWlsdGluX2Nob29zZV9leHByKHNpemVvZih2
KSA9PSBzaXplb2YodWludDY0X3QpLCBiZTY0X3RvX2NwdSh2KSwgXA0KPiArCQkodm9pZCkwKSkp
KQ0KLi4uDQoNCkknbSBub3QgYXQgYWxsIHN1cmUgdGhhdCB1c2luZyB0aGUgJ3NpemUnIG9mIHRo
ZSBjb25zdGFudCB3aWxsIHJlZHVjZQ0KdGhlIG51bWJlciBvZiBidWdzIC0gaXQganVzdCBpbnRy
b2R1Y2VzIGEgd2hvbGUgbmV3IGNhdGVnb3J5IG9mIGJ1Z3MuDQoNClVzaW5nIHRoZSBzaXplIG9m
IHRoZSBkZXN0aW5hdGlvbiBtaWdodCBoZWxwLCBidXQgdGhhdCBtYWtlcyB0aGUgY29kZQ0KdWds
eS4NCg0KR2V0dGluZyBvbmUgb2YgdGhlIHN0YXRpYyBhbmFseXNlcnMgdG8gZmluZCB0aGUgb2J2
aW91cyBlcnJvcnMgaXMNCnByb2JhYmx5IG1vcmUgYXBwcm9wcmlhdGUuDQoNCglEYXZpZA0KDQo=
