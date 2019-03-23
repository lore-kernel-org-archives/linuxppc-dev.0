Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E73DC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 05:51:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D7F218A5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 05:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D7F218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44R8lf40WqzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 16:51:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.169; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44R8jr4lzPzDqMp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 16:49:31 +1100 (AEDT)
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
 by Forcepoint Email with ESMTPS id 7173FB43ECF43552F251;
 Sat, 23 Mar 2019 13:49:26 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse02.zte.com.cn with SMTP id x2N5nLbe068910;
 Sat, 23 Mar 2019 13:49:21 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Sat, 23 Mar 2019 13:49:23 +0800 (CST)
Date: Sat, 23 Mar 2019 13:49:23 +0800 (CST)
X-Zmail-TransId: 2b045c95c8e3f7a0dd6f
X-Mailer: Zmail v1.0
Message-ID: <201903231349235197028@zte.com.cn>
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <christophe.leroy@c-s.fr>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggNS81XSBwb3dlcnBjLzh4eDogZml4IHBvc3NpYmxlIG9iamVjdCByZWZlcmVuY2UgbGVhaw==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn x2N5nLbe068910
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
Cc: wang.yi59@zte.com.cn, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
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

SGksIENocmlzdG9waGUsCgo+PiBUaGUgY2FsbCB0byBvZl9maW5kX2NvbXBhdGlibGVfbm9kZSBy
ZXR1cm5zIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291bnQKPj4gaW5jcmVtZW50ZWQgdGh1cyBp
dCBtdXN0IGJlIGV4cGxpY2l0bHkgZGVjcmVtZW50ZWQgYWZ0ZXIgdGhlIGxhc3QKPj4gdXNhZ2Uu
Cj4+IGlycV9kb21haW5fYWRkX2xpbmVhciBhbHNvIGNhbGxzIG9mX25vZGVfZ2V0IHRvIGluY3Jl
YXNlIHJlZmNvdW50LAo+PiBzbyBpcnFfZG9tYWluIHdpbGwgbm90IGJlIGFmZmVjdGVkIHdoZW4g
aXQgaXMgcmVsZWFzZWQuCj4KPgo+IFNob3VsZCB5b3UgaGF2ZSBhOgo+Cj4gRml4ZXM6IGE4ZGI4
Y2YwZDg5NCAoImlycV9kb21haW46IFJlcGxhY2UgaXJxX2FsbG9jX2hvc3QoKSB3aXRoCj4gcmV2
bWFwLXNwZWNpZmljIGluaXRpYWxpemVycyIpCj4KPiBJZiBub3QsIGl0IG1lYW5zIHlvdXIgY2hh
bmdlIGlzIGluIGNvbnRyYWRpY3Rpb24gd2l0aCBjb21taXQKPiBiMTcyNWM5MzE5YWEgKCJbUE9X
RVJQQ10gYXJjaC9wb3dlcnBjL3N5c2RldjogQWRkIG1pc3Npbmcgb2Zfbm9kZV9wdXQiKQoKVGhh
bmsgeW91IHZlcnkgbXVjaC4KVGhpcyBwcm9ibGVtIGV4aXN0ZWQgYmVmb3JlIHRoaXMgY29tbWl0
IChhOGRiOGNmMGQ4OTQpLgphbmQgdGhlIFNtUEwgd2UgdXNlZCBpczoKaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMTkvMy8xNC84ODAKV2UgYXJlIHN0aWxsIGltcHJvdmluZyB0aGlzIFNtUEwsIGFu
ZCBpdCBpcyBzb21ld2hhdCBkaWZmZXJlbnQgZnJvbSB0aGUgc2NyaXB0IAp1c2VkIGJ5IGIxNzI1
YzkzMTlhYSAoIltQT1dFUlBDXSBhcmNoL3Bvd2VycGMvc3lzZGV2OiBBZGQgbWlzc2luZyBvZl9u
b2RlX3B1dCIpLgoKPj4gRGV0ZWN0ZWQgYnkgY29jY2luZWxsZSB3aXRoIHRoZSBmb2xsb3dpbmcg
d2FybmluZ3M6Cj4+IC4vYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84eHgvcGljLmM6MTU4OjEtNzog
RVJST1I6IG1pc3Npbmcgb2Zfbm9kZV9wdXQ7IGFjcXVpcmVkIGEgbm9kZSBwb2ludGVyIHdpdGgg
cmVmY291bnQgaW5jcmVtZW50ZWQgb24gbGluZSAxMzYsIGJ1dCB3aXRob3V0IGEgY29ycmVzcG9u
ZGluZyBvYmplY3QgcmVsZWFzZSB3aXRoaW4gdGhpcyBmdW5jdGlvbi4KPj4KPj4gICBhcmNoL3Bv
d2VycGMvcGxhdGZvcm1zLzh4eC9waWMuYyB8IDEgKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84eHgv
cGljLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzh4eC9waWMuYwo+PiBpbmRleCA4ZDVhMjVk
Li4xM2Q4ODBiIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzh4eC9waWMu
Ywo+PiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzh4eC9waWMuYwo+PiBAQCAtMTU1LDYg
KzE1NSw3IEBAIGludCBtcGM4eHhfcGljX2luaXQodm9pZCkKPj4gICAgICAgICAgIHJldCA9IC1F
Tk9NRU07Cj4+ICAgICAgICAgICBnb3RvIG91dDsKPj4gICAgICAgfQo+PiArICAgIG9mX25vZGVf
cHV0KG5wKTsKPj4gICAgICAgcmV0dXJuIDA7Cj4+Cj4+ICAgb3V0Ogo+Pgo+Cj4gSSBndWVzcyBp
dCB3b3VsZCBiZSBiZXR0ZXIgYXMgZm9sbG93czoKPiAKPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzh4eC9waWMuYwo+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvOHh4L3BpYy5j
Cj4gQEAgLTE1Myw5ICsxNTMsNyBAQCBpbnQgbXBjOHh4X3BpY19pbml0KHZvaWQpCj4gaWYgKG1w
Yzh4eF9waWNfaG9zdCA9PSBOVUxMKSB7Cj4gcHJpbnRrKEtFUk5fRVJSICJNUEM4eHggUElDOiBm
YWlsZWQgdG8gYWxsb2NhdGUgaXJxCj4gaG9zdCFcbiIpOwo+IHJldCA9IC1FTk9NRU07Cj4gLSAg
ICAgICAgICAgICAgIGdvdG8gb3V0Owo+IH0KPiAtICAgICAgIHJldHVybiAwOwo+IAo+IG91dDoK
PiBvZl9ub2RlX3B1dChucCk7CgpPSy4KVGhhbmsgeW91LgpXZSB3aWxsIGZpeCBpdCBzb29uLgoK
VGhhbmtzIGFuZCByZWdhcmRzLApXZW4=


--=====_003_next=====--

--=====_001_next=====--

