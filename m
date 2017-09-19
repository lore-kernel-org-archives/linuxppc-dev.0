Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJbZ1ky4zDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:12:57 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'wei.guo.simon@gmail.com'" <wei.guo.simon@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: RE: [PATCH v1 1/3] powerpc: Align bytes before fall back to .Lshort
 in powerpc memcmp
Date: Tue, 19 Sep 2017 10:12:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0079D63@AcuExch.aculab.com>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
 <1505815439-18720-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505815439-18720-2-git-send-email-wei.guo.simon@gmail.com>
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

RnJvbTogd2VpLmd1by5zaW1vbkBnbWFpbC5jb20NCj4gU2VudDogMTkgU2VwdGVtYmVyIDIwMTcg
MTE6MDQNCj4gQ3VycmVudGx5IG1lbWNtcCgpIGluIHBvd2VycGMgd2lsbCBmYWxsIGJhY2sgdG8g
LkxzaG9ydCAoY29tcGFyZSBwZXIgYnl0ZQ0KPiBtb2RlKSBpZiBlaXRoZXIgc3JjIG9yIGRzdCBh
ZGRyZXNzIGlzIG5vdCA4IGJ5dGVzIGFsaWduZWQuIEl0IGNhbiBiZQ0KPiBvcG1pdGl6ZWQgaWYg
Ym90aCBhZGRyZXNzZXMgYXJlIHdpdGggdGhlIHNhbWUgb2Zmc2V0IHdpdGggOCBieXRlcyBib3Vu
ZGFyeS4NCj4gDQo+IG1lbWNtcCgpIGNhbiBhbGlnbiB0aGUgc3JjL2RzdCBhZGRyZXNzIHdpdGgg
OCBieXRlcyBmaXJzdGx5IGFuZCB0aGVuDQo+IGNvbXBhcmUgd2l0aCAuTGxvbmcgbW9kZS4NCg0K
V2h5IG5vdCBtYXNrIGJvdGggYWRkcmVzc2VzIHdpdGggfjcgYW5kIG1hc2svc2hpZnQgdGhlIHJl
YWQgdmFsdWUgdG8gaWdub3JlDQp0aGUgdW53YW50ZWQgaGlnaCAoQkUpIG9yIGxvdyAoTEUpIGJp
dHMuDQoNClRoZSBzYW1lIGNhbiBiZSBkb25lIGF0IHRoZSBlbmQgb2YgdGhlIGNvbXBhcmUgd2l0
aCBhbnkgZmluYWwsIHBhcnRpYWwgd29yZC4NCg0KCURhdmlkDQogDQo=
