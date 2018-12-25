Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8EC64E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 02:55:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0288521773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 02:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0288521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43P11B4tHtzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 13:55:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43P0z02G5mzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Dec 2018 13:53:14 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 266703B75347B295C1FA;
 Tue, 25 Dec 2018 10:53:12 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse01.zte.com.cn with SMTP id wBP2r51d043820;
 Tue, 25 Dec 2018 10:53:05 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 25 Dec 2018 10:53:06 +0800 (CST)
Date: Tue, 25 Dec 2018 10:53:06 +0800 (CST)
X-Zmail-TransId: 2b055c219b92f787440f
X-Mailer: Zmail v1.0
Message-ID: <201812251053063773660@zte.com.cn>
In-Reply-To: <VI1PR04MB3247C250649F9CB3490D83A491B40@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: 1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn,
 VI1PR04MB3247C250649F9CB3490D83A491B40@VI1PR04MB3247.eurprd04.prod.outlook.com
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <qiang.zhao@nxp.com>
Subject: =?UTF-8?B?UmU6UkU6IFtQQVRDSF0gc29jL2ZzbC9xZTogZml4IGVyciBoYW5kbGluZyBvZiB1Y2Nfb2ZfcGFyc2VfdGRt?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn wBP2r51d043820
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, julia.lawall@lip6.fr,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgUWlhbmcsICAKVGhhbmsgeW91LCB3ZSdsbCBzZW5kIGEgbmV3IHZlcnNpb24gdG8gZml4IHRo
aXMuCgpCZXN0IHJlZ2FyZHMsCiAgV2VuCgotLS0tLS0tLS0tLS0tLS0tLS1PcmlnaW5hbCBNYWls
LS0tLS0tLS0tLS0tLS0tLS0tClNlbmRlcjogUWlhbmdaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+
ClRvOiB3YW5nIHlpMTAxMjk5NjM7CkNDOiB6aG9uZyB3ZWlkb25nMTAwMDEwODg7bGttbCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz5qdWxpYS5sYXdhbGxAbGlwNi5mciA8anVsaWEubGF3
YWxsQGxpcDYuZnI+bGludXhwcGMtZGV2IDxsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZz53
ZW4geWFuZzEwMTU2MzE0O21vZGVyYXRlZGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJN
IEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPkxlbyBM
aSA8bGVveWFuZy5saUBueHAuY29tPgpEYXRlOiAyMDE4LzEyLzI1IDA5OjU4ClN1YmplY3Q6IFJF
OiBbUEFUQ0hdIHNvYy9mc2wvcWU6IGZpeCBlcnIgaGFuZGxpbmcgb2YgdWNjX29mX3BhcnNlX3Rk
bQpIaSBXZW4sCgpXaWxsIHlvdSBzZW5kIGFub3RoZXIgdmVyc2lvbiB0byByZXNvbHZlIHRoZSBp
c3N1ZSBkZXNjcmliZWQgaW4gdGhlIGNvbW1lbnRzPwoKQlIKUWlhbmcKCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5jb20+Cj4gU2Vu
dDogMjAxOOW5tDEy5pyINuaXpSA0OjEwCj4gVG86IHdhbmcueWk1OUB6dGUuY29tLmNuCj4gQ2M6
IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT47IHpob25nLndlaWRvbmdAenRlLmNvbS5j
bjsgbGttbAo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsganVsaWEubGF3YWxsQGxp
cDYuZnI7IGxpbnV4cHBjLWRldgo+IDxsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZz47IHdl
bi55YW5nOTlAenRlLmNvbS5jbjsgbW9kZXJhdGVkCj4gbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAv
IE1YQyBBUk0gQVJDSElURUNUVVJFCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZz4KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2MvZnNsL3FlOiBmaXggZXJyIGhhbmRsaW5n
IG9mIHVjY19vZl9wYXJzZV90ZG0KPgo+IE9uIFRodSwgTm92IDIyLCAyMDE4IGF0IDI6NDIgUE0g
WWkgV2FuZyA8d2FuZy55aTU5QHp0ZS5jb20uY24+IHdyb3RlOgo+ID4KPiA+IEZyb206IFdlbiBZ
YW5nIDx3ZW4ueWFuZzk5QHp0ZS5jb20uY24+Cj4gPgo+ID4gQ3VycmVudGx5IHRoZXJlIGFyZSAy
IHByb2JsZW1zIHdpdGggdGhlIHVjY19vZl9wYXJzZV90ZG0gZnVuY3Rpb246Cj4gPiAxLGEgcG9z
c2libGUgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIHVjY19vZl9wYXJzZV90ZG0sIGRldGVj
dGVkIGJ5Cj4gPiB0aGUgc2VtYW50aWMgcGF0Y2ggZGVyZWZfbnVsbC5jb2NjaSwgd2l0aCB0aGUg
Zm9sbG93aW5nIHdhcm5pbmc6Cj4gPiBkcml2ZXJzL3NvYy9mc2wvcWUvcWVfdGRtLmM6MTc3OjIx
LTI0OiBFUlJPUjogcGRldiBpcyBOVUxMIGJ1dAo+IGRlcmVmZXJlbmNlZC4KPiA+IDIsZGV2IGdl
dHMgbW9kaWZpZWQsIHNvIGluIGFueSBjYXNlIHRoYXQgZGV2bV9pb3VubWFwKCkgd2lsbCBmYWls
IGV2ZW4KPiA+IHdoZW4gdGhlIG5ldyBwZGV2IGlzIHZhbGlkLCBiZWNhdXNlIHRoZSBpb21hcCB3
YXMgZG9uZSB3aXRoIGEgZGlmZmVyZW50Cj4gcGRldi4KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhl
bS4KPgo+IFdoaWxlIHdlIGFyZSBhdCB0aGlzLCBJIHRoaW5rIHRoaXMgbG9naWMgbmVlZCBtb3Jl
IHNlcmlvdXMgZml4aW5nLiAgSSBzZWUgdGhlcmUgaXMKPiBubyBkcml2ZXIgYmluZCB3aXRoIHRo
ZSAiZnNsLHQxMDQwLXFlLXNpIiBvciAiZnNsLHQxMDQwLXFlLXNpcmFtIiBkZXZpY2UuICBTbwo+
IGFsbG9jYXRpbmcgcmVzb3VyY2VzIHVzaW5nIGRldm1fKigpIHdpdGggdGhlc2UgZGV2aWNlcyB3
b24ndCBwcm92aWRlIGEKPiBjbGVhbnVwIHBhdGggZm9yIHRoZXNlIHJlc291cmNlcyB3aGVuIHRo
ZSBjYWxsZXIgZmFpbHMuICBJIHRoaW5rIHdlIHNob3VsZAo+IHByb2JhYmx5IGFsbG9jYXRlIHJl
c291cmNlIHVuZGVyIGRldmljZSBvZiBjYWxsZXIgKGUuZy4gdWNjLWhkbGMpLCBzbyB0aGF0IHdo
ZW4KPiBjYWxsZXIgcHJvYmUgZmFpbHMgb3IgaXMgcmVtb3ZlZCBpdCB3aWxsIHRyaWdnZXIgdGhl
IGNsZWFudXAuCj4KPiA+Cj4gPiBTdWdnZXN0ZWQtYnk6IENocmlzdG9waGUgTEVST1kgPGNocmlz
dG9waGUubGVyb3lAYy1zLmZyPgo+ID4gU2lnbmVkLW9mZi1ieTogV2VuIFlhbmcgPHdlbi55YW5n
OTlAenRlLmNvbS5jbj4KPiA+IENDOiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBsaXA2LmZy
Pgo+ID4gQ0M6IFpoYW8gUWlhbmcgPHFpYW5nLnpoYW9AbnhwLmNvbT4KPiA+IC0tLQo+ID4gIGRy
aXZlcnMvc29jL2ZzbC9xZS9xZV90ZG0uYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWUvcWVfdGRtLmMgYi9kcml2ZXJzL3NvYy9m
c2wvcWUvcWVfdGRtLmMKPiA+IGluZGV4IGY3OGMzNDYuLjlhMjlmMGIgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9mc2wvcWUvcWVfdGRtLmMKPiA+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9x
ZS9xZV90ZG0uYwo+ID4gQEAgLTQ3LDcgKzQ3LDcgQEAgaW50IHVjY19vZl9wYXJzZV90ZG0oc3Ry
dWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0Cj4gdWNjX3RkbSAqdXRkbSwKPiA+ICAgICAgICAg
c3RydWN0IHJlc291cmNlICpyZXM7Cj4gPiAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAy
Owo+ID4gICAgICAgICBzdGF0aWMgaW50IHNpcmFtX2luaXRfZmxhZzsKPiA+IC0gICAgICAgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKPiA+ICsgICAgICAgc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldl9zaSwgKnBkZXZfc2lyYW07Cj4gPgo+ID4gICAgICAgICBzcHJvcCA9IG9mX2dl
dF9wcm9wZXJ0eShucCwgImZzbCxyeC1zeW5jLWNsb2NrIiwgTlVMTCk7Cj4gPiAgICAgICAgIGlm
IChzcHJvcCkgewo+ID4gQEAgLTEyOSwxNiArMTI5LDE2IEBAIGludCB1Y2Nfb2ZfcGFyc2VfdGRt
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsCj4gc3RydWN0IHVjY190ZG0gKnV0ZG0sCj4gPiAgICAg
ICAgIGlmICghbnAyKQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4KPiA+
IC0gICAgICAgcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobnAyKTsKPiA+IC0gICAgICAg
aWYgKCFwZGV2KSB7Cj4gPiArICAgICAgIHBkZXZfc2kgPSBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KG5wMik7Cj4gPiArICAgICAgIGlmICghcGRldl9zaSkgewo+ID4gICAgICAgICAgICAgICAgIHBy
X2VycigiJXBPRm46IGZhaWxlZCB0byBsb29rdXAgcGRldlxuIiwgbnAyKTsKPiA+ICAgICAgICAg
ICAgICAgICBvZl9ub2RlX3B1dChucDIpOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOwo+ID4gICAgICAgICB9Cj4gPgo+ID4gICAgICAgICBvZl9ub2RlX3B1dChucDIpOwo+ID4g
LSAgICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOwo+ID4gLSAgICAgICB1dGRtLT5zaV9yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZw
ZGV2LT5kZXYsIHJlcyk7Cj4gPiArICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2X3NpLCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gPiArICAgICAgIHV0ZG0tPnNpX3JlZ3MgPSBk
ZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXZfc2ktPmRldiwgcmVzKTsKPiA+ICAgICAgICAgaWYg
KElTX0VSUih1dGRtLT5zaV9yZWdzKSkgewo+ID4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9F
UlIodXRkbS0+c2lfcmVncyk7Cj4gPiAgICAgICAgICAgICAgICAgZ290byBlcnJfbWlzc19zaXJh
bV9wcm9wZXJ0eTsgQEAgLTE1MCw4ICsxNTAsOCBAQAo+IGludAo+ID4gdWNjX29mX3BhcnNlX3Rk
bShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBzdHJ1Y3QgdWNjX3RkbSAqdXRkbSwKPiA+ICAgICAg
ICAgICAgICAgICBnb3RvIGVycl9taXNzX3NpcmFtX3Byb3BlcnR5Owo+ID4gICAgICAgICB9Cj4g
Pgo+ID4gLSAgICAgICBwZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucDIpOwo+ID4gLSAg
ICAgICBpZiAoIXBkZXYpIHsKPiA+ICsgICAgICAgcGRldl9zaXJhbSA9IG9mX2ZpbmRfZGV2aWNl
X2J5X25vZGUobnAyKTsKPiA+ICsgICAgICAgaWYgKCFwZGV2X3NpcmFtKSB7Cj4gPiAgICAgICAg
ICAgICAgICAgcmV0ID0gLUVJTlZBTDsKPiA+ICAgICAgICAgICAgICAgICBwcl9lcnIoIiVwT0Zu
OiBmYWlsZWQgdG8gbG9va3VwIHBkZXZcbiIsIG5wMik7Cj4gPiAgICAgICAgICAgICAgICAgb2Zf
bm9kZV9wdXQobnAyKTsKPiA+IEBAIC0xNTksOCArMTU5LDggQEAgaW50IHVjY19vZl9wYXJzZV90
ZG0oc3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0Cj4gdWNjX3RkbSAqdXRkbSwKPiA+ICAg
ICAgICAgfQo+ID4KPiA+ICAgICAgICAgb2Zfbm9kZV9wdXQobnAyKTsKPiA+IC0gICAgICAgcmVz
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKPiA+IC0g
ICAgICAgdXRkbS0+c2lyYW0gPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVz
KTsKPiA+ICsgICAgICAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXZfc2lyYW0sIElP
UkVTT1VSQ0VfTUVNLCAwKTsKPiA+ICsgICAgICAgdXRkbS0+c2lyYW0gPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoJnBkZXZfc2lyYW0tPmRldiwgcmVzKTsKPiA+ICAgICAgICAgaWYgKElTX0VSUih1
dGRtLT5zaXJhbSkpIHsKPiA+ICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHV0ZG0tPnNp
cmFtKTsKPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9taXNzX3NpcmFtX3Byb3BlcnR5OyBA
QCAtMTc0LDcgKzE3NCw3IEBACj4gaW50Cj4gPiB1Y2Nfb2ZfcGFyc2VfdGRtKHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbnAsIHN0cnVjdCB1Y2NfdGRtICp1dGRtLAo+ID4gICAgICAgICByZXR1cm4gcmV0
Owo+ID4KPiA+ICBlcnJfbWlzc19zaXJhbV9wcm9wZXJ0eToKPiA+IC0gICAgICAgZGV2bV9pb3Vu
bWFwKCZwZGV2LT5kZXYsIHV0ZG0tPnNpX3JlZ3MpOwo+ID4gKyAgICAgICBkZXZtX2lvdW5tYXAo
JnBkZXZfc2ktPmRldiwgdXRkbS0+c2lfcmVncyk7Cj4gPiAgICAgICAgIHJldHVybiByZXQ7Cj4g
PiAgfQo+ID4gIEVYUE9SVF9TWU1CT0wodWNjX29mX3BhcnNlX3RkbSk7Cj4gPiAtLQo+ID4gMi45
LjUKPiA+


--=====_003_next=====--

--=====_001_next=====--

