Return-Path: <shc_work@mail.ru>
Received: from fallback7.mail.ru (fallback7.mail.ru [94.100.181.128])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sfBnw6ZVgzDspc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:58:28 +1000 (AEST)
From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
To: =?UTF-8?B?WWFuZ2JvIEx1?= <yangbo.lu@nxp.com>
Cc: =?UTF-8?B?TWFyayBSdXRsYW5k?= <mark.rutland@arm.com>,
 =?UTF-8?B?WGlhb2JvIFhpZQ==?= <xiaobo.xie@nxp.com>,
 =?UTF-8?B?TWluZ2h1YW4gTGlhbg==?= <minghuan.lian@nxp.com>,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 =?UTF-8?B?UWlhbmcgWmhhbw==?= <qiang.zhao@nxp.com>,
 =?UTF-8?B?UnVzc2VsbCBLaW5n?= <linux@arm.linux.org.uk>,
 =?UTF-8?B?Qmh1cGVzaCBTaGFybWE=?= <bhupesh.sharma@freescale.com>,
 =?UTF-8?B?Sm9lcmcgUm9lZGVs?= <joro@8bytes.org>,
 =?UTF-8?B?Sm9jaGVuIEZyaWVkcmljaA==?= <jochen@scram.de>,
 =?UTF-8?B?Q2xhdWRpdSBNYW5vaWw=?= <claudiu.manoil@freescale.com>,
 devicetree@vger.kernel.org,
 =?UTF-8?B?S3VtYXIgR2FsYQ==?= <galak@codeaurora.org>,
 =?UTF-8?B?Um9iIEhlcnJpbmc=?= <robh+dt@kernel.org>,
 =?UTF-8?B?U2FudG9zaCBTaGlsaW1rYXI=?= <ssantosh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TGVvIExp?= <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 =?UTF-8?B?U2NvdHQgV29vZA==?= <oss@buserror.net>,
 =?UTF-8?B?QXJuZCBCZXJnbWFubg==?= <arnd@arndb.de>
Subject: =?UTF-8?B?UmU6IFt2MTIsIDcvOF0gYmFzZTogc29jOiBpbnRyb2R1Y2Ugc29jX2Rldmlj?=
 =?UTF-8?B?ZV9tYXRjaCgpIGludGVyZmFjZQ==?=
MIME-Version: 1.0
Date: Wed, 21 Sep 2016 10:56:14 +0300
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Message-ID: <1474444574.270880035@f136.i.mail.ru>
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1474441040-11946-8-git-send-email-yangbo.lu@nxp.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
 <1474441040-11946-8-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PtCh0YDQtdC00LAsIDIxINGB0LXQvdGC0Y/QsdGA0Y8gMjAxNiwgOTo1NyArMDM6MDAg0L7RgiBZ
YW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPjoKPgo+RnJvbTogQXJuZCBCZXJnbWFubiA8IGFy
bmRAYXJuZGIuZGUgPgo+Cj5XZSBrZWVwIHJ1bm5pbmcgaW50byBjYXNlcyB3aGVyZSBkZXZpY2Ug
ZHJpdmVycyB3YW50IHRvIGtub3cgdGhlIGV4YWN0Cj52ZXJzaW9uIG9mIHRoZSBhIFNvQyB0aGV5
IGFyZSBjdXJyZW50bHkgcnVubmluZyBvbi4gSW4gdGhlIHBhc3QsIHRoaXMgaGFzCj51c3VhbGx5
IGJlZW4gZG9uZSB0aHJvdWdoIGEgdmVuZG9yIHNwZWNpZmljIEFQSSB0aGF0IGNhbiBiZSBjYWxs
ZWQgYnkgYQo+ZHJpdmVyLCBvciBieSBkaXJlY3RseSBhY2Nlc3Npbmcgc29tZSBraW5kIG9mIHZl
cnNpb24gcmVnaXN0ZXIgdGhhdCBpcwo+bm90IHBhcnQgb2YgdGhlIGRldmljZSBpdHNlbGYgYnV0
IHRoYXQgYmVsb25ncyB0byBhIGdsb2JhbCByZWdpc3RlciBhcmVhCj5vZiB0aGUgY2hpcC4KLi4u
Cj4rY29uc3Qgc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICpzb2NfZGV2aWNlX21hdGNoKAo+
K2NvbnN0IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqbWF0Y2hlcykKPit7Cj4raW50IHJl
dCA9IDA7Cj4rCj4raWYgKCFtYXRjaGVzKQo+K3JldHVybiBOVUxMOwo+Kwo+K3doaWxlICghcmV0
KSB7Cj4raWYgKCEobWF0Y2hlcy0+bWFjaGluZSB8fCBtYXRjaGVzLT5mYW1pbHkgfHwKPisgICAg
ICBtYXRjaGVzLT5yZXZpc2lvbiB8fCBtYXRjaGVzLT5zb2NfaWQpKQo+K2JyZWFrOwo+K3JldCA9
IGJ1c19mb3JfZWFjaF9kZXYoJnNvY19idXNfdHlwZSwgTlVMTCwgKHZvaWQgKiltYXRjaGVzLAo+
KyAgICAgICBzb2NfZGV2aWNlX21hdGNoX29uZSk7Cj4raWYgKCFyZXQpCj4rbWF0Y2hlcysrOwoK
U28sIHdoYXQgaGFwcGVuIGlmIG5leHQgIm1hdGNoZXMiIChhZnRlciBpbmNyZW1lbnQpIHdpbGwg
YmUgTlVMTD8KCkkgdGhpbmsgeW91IHNob3VsZCB1c2Ugd2hpbGUobWF0Y2hlcykgYXQgdGhlIHN0
YXJ0IG9mIHRoaXMgcHJvY2VkdXJlLgoKLS0tCgo=
