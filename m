Return-Path: <scott.wood@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0067.outbound.protection.outlook.com [157.55.234.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A1BF1A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 04:51:14 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Hongtao Jia <hongtao.jia@nxp.com>, Arnd Bergmann <arnd@arndb.de>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>
CC: Hongtao Jia <hongtao.jia@freescale.com>, "edubezval@gmail.com"
 <edubezval@gmail.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Scott Wood
 <oss@buserror.net>
Subject: =?gb2312?B?UmU6ILTwuLQ6IFtQQVRDSCBWM10gY3B1ZnJlcTogcW9yaXE6IFJlZ2lzdGVy?=
 =?gb2312?Q?_cooling_device_based_on_device_tree?=
Date: Mon, 11 Jan 2016 17:34:52 +0000
Message-ID: <AM3PR04MB530F71205574CA86CADE93191C90@AM3PR04MB530.eurprd04.prod.outlook.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <1697588.dLcbZBRWO4@vostro.rjw.lan> <3550740.QzZi28fbXg@wuerfel>
 <AM3PR04MB3376CC754973BD535CF3F99EBC90@AM3PR04MB337.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gMDEvMTEvMjAxNiAwODo1NCBBTSwgSG9uZ3RhbyBKaWEgd3JvdGU6Cj4gU29ycnkgZm9yIHRo
ZSBsYXRlIHJlc3BvbnNlLiBJIGdvdCBhIGtuZWUgc3VyZ2VyeSB0byBkby4KPiBTZWUgY29tbWVu
dHMgYXQgdGhlIGVuZC4KPiAKPj4gLS0tLS3Tyrz+1K28/i0tLS0tCj4+ILeivP7IyzogQXJuZCBC
ZXJnbWFubiBbbWFpbHRvOmFybmRAYXJuZGIuZGVdCj4+ILeiy83KsbzkOiBTYXR1cmRheSwgRGVj
ZW1iZXIgMTksIDIwMTUgNjozMyBBTQo+PiDK1bz+yMs6IFJhZmFlbCBKLiBXeXNvY2tpIDxyandA
cmp3eXNvY2tpLm5ldD4KPj4gs63LzTogSmlhIEhvbmd0YW8gPGhvbmd0YW8uamlhQGZyZWVzY2Fs
ZS5jb20+OyBlZHViZXp2YWxAZ21haWwuY29tOwo+PiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsg
bGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0KPj4gZGV2QGxpc3RzLm96bGFicy5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTY290dCBXb29kCj4+IDxzY290dHdvb2RA
ZnJlZXNjYWxlLmNvbT4KPj4g1vfM4jogUmU6IFtQQVRDSCBWM10gY3B1ZnJlcTogcW9yaXE6IFJl
Z2lzdGVyIGNvb2xpbmcgZGV2aWNlIGJhc2VkIG9uIGRldmljZQo+PiB0cmVlCj4+Cj4+IE9uIFR1
ZXNkYXkgMTUgRGVjZW1iZXIgMjAxNSAwMDo1ODoyNiBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToK
Pj4+IE9uIFRodXJzZGF5LCBOb3ZlbWJlciAyNiwgMjAxNSAwNToyMToxMSBQTSBKaWEgSG9uZ3Rh
byB3cm90ZToKPj4+PiBSZWdpc3RlciB0aGUgcW9yaXEgY3B1ZnJlcSBkcml2ZXIgYXMgYSBjb29s
aW5nIGRldmljZSwgYmFzZWQgb24gdGhlCj4+Pj4gdGhlcm1hbCBkZXZpY2UgdHJlZSBmcmFtZXdv
cmsuIFdoZW4gdGVtcGVyYXR1cmUgY3Jvc3NlcyB0aGUgcGFzc2l2ZQo+Pj4+IHRyaXAgcG9pbnQg
Y3B1ZnJlcSBpcyB1c2VkIHRvIHRocm90dGxlIENQVXMuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBKaWEgSG9uZ3RhbyA8aG9uZ3Rhby5qaWFAZnJlZXNjYWxlLmNvbT4KPj4+PiBSZXZpZXdlZC1i
eTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KPj4+Cj4+PiBBcHBsaWVk
LCB0aGFua3MhCj4+Pgo+Pgo+PiBJIGdvdCBhIHJhbmRjb25maWcgYnVpbGQgZXJyb3IgdG9kYXk6
Cj4+Cj4+IGRyaXZlcnMvYnVpbHQtaW4ubzogSW4gZnVuY3Rpb24gYHFvcmlxX2NwdWZyZXFfcmVh
ZHknOgo+PiBkZWJ1Z2ZzLmM6KC50ZXh0KzB4MWY0Njg4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
bwo+PiBgb2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyJwo+Pgo+PiBDT05GSUdfT0Y9eQo+PiBD
T05GSUdfUU9SSVFfQ1BVRlJFUT15Cj4+IENPTkZJR19USEVSTUFMPW0KPj4gQ09ORklHX1RIRVJN
QUxfT0Y9eQo+Pgo+PiBJIHRoaW5rIHlvdSBuZWVkIGEgJ2RlcGVuZHMgb24gVEhFUk1BTCcgdG8g
cHJldmVudCB0aGUgZHJpdmVyIGZyb20gYmVpbmcKPj4gYnVpbHQtaW4gd2hlbiBUSEVSTUFMPW0u
Cj4+Cj4+IEFybmQKPiAKPiBDb3JyZWN0LiBJIG5lZWQgdG8gYWRkIGZvbGxvd2luZyBsaW5lcyB0
byB0aGUgS2NvbmZpZyBmaWxlOgo+IGRlcGVuZHMgb24gIUNQVV9USEVSTUFMIHx8IFRIRVJNQUw9
eQo+IAo+IEhpIFJhZmFlbCwKPiBTaG91bGQgSSBzZW5kIGEgbmV3IHBhdGNoIGluY2x1ZGUgdGhp
cyBmaXggb3Igc2VuZCBhIGZpeCBwYXRjaD8KCldoeSBUSEVSTUFMPXkgYW5kIG5vdCBqdXN0IFRI
RVJNQUwsIHdoaWNoIHdvdWxkIGFsbG93IGJ1aWxkaW5nIHRoaXMKZHJpdmVyIGFzIGEgbW9kdWxl
PwoKLVNjb3R0Cgo=
