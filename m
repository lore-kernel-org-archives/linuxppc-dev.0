Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 01:20:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE4220693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 01:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44StcM6jbYzDqD9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 12:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44StZl0zZGzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 12:19:24 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 07D00DFBA0AEFEE4137D;
 Tue, 26 Mar 2019 09:19:20 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse01.zte.com.cn with SMTP id x2Q1Ikko003442;
 Tue, 26 Mar 2019 09:19:11 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 26 Mar 2019 09:19:11 +0800 (CST)
Date: Tue, 26 Mar 2019 09:19:11 +0800 (CST)
X-Zmail-TransId: 2b045c997e0fa9fb5cf6
X-Mailer: Zmail v1.0
Message-ID: <201903260919119865929@zte.com.cn>
In-Reply-To: <87d0mfp6w6.fsf@concordia.ellerman.id.au>
References: 1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn,
 87d0mfp6w6.fsf@concordia.ellerman.id.au
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <mpe@ellerman.id.au>
Subject: =?UTF-8?B?562U5aSNOiBSZTogW1BBVENIIHYyXSBwb3dlcnBjLzh4eDogZml4IHBvc3NpYmxlIG9iamVjdCByZWZlcmVuY2UgbGVhaw==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn x2Q1Ikko003442
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
Cc: peng.hao2@zte.com.cn, linux-kernel@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
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

Pj4gVGhlIGNhbGwgdG8gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUgcmV0dXJucyBhIG5vZGUgcG9p
bnRlciB3aXRoIHJlZmNvdW50Cj4+IGluY3JlbWVudGVkIHRodXMgaXQgbXVzdCBiZSBleHBsaWNp
dGx5IGRlY3JlbWVudGVkIGFmdGVyIHRoZSBsYXN0Cj4+IHVzYWdlLgo+PiBpcnFfZG9tYWluX2Fk
ZF9saW5lYXIgYWxzbyBjYWxscyBvZl9ub2RlX2dldCB0byBpbmNyZWFzZSByZWZjb3VudCwKPj4g
c28gaXJxX2RvbWFpbiB3aWxsIG5vdCBiZSBhZmZlY3RlZCB3aGVuIGl0IGlzIHJlbGVhc2VkLgo+
Pgo+PiBEZXRlY3RlZCBieSBjb2NjaW5lbGxlIHdpdGggdGhlIGZvbGxvd2luZyB3YXJuaW5nczoK
Pj4gLi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzh4eC9waWMuYzoxNTg6MS03OiBFUlJPUjogbWlz
c2luZyBvZl9ub2RlX3B1dDsgYWNxdWlyZWQgYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3VudCBp
bmNyZW1lbnRlZCBvbiBsaW5lIDEzNiwgYnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVj
dCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLgo+Pgo+PiBGaXhlczogYThkYjhjZjBkODk0
ICgiaXJxX2RvbWFpbjogUmVwbGFjZSBpcnFfYWxsb2NfaG9zdCgpIHdpdGgKPj4gcmV2bWFwLXNw
ZWNpZmljIGluaXRpYWxpemVycyIpCj4+IFNpZ25lZC1vZmYtYnk6IFdlbiBZYW5nIDx3ZW4ueWFu
Zzk5QHp0ZS5jb20uY24+Cj4+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0
b3BoZS5sZXJveUBjLXMuZnI+Cj4+IFJldmlld2VkLWJ5OiBQZW5nIEhhbyA8cGVuZy5oYW8yQHp0
ZS5jb20uY24+Cj4+IENjOiBWaXRhbHkgQm9yZHVnIDx2aXRiQGtlcm5lbC5jcmFzaGluZy5vcmc+
Cj4+IENjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+
Cj4+IENjOiBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4KPj4gQ2M6IE1pY2hhZWwg
RWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4KPj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnCj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+IC0tLQo+PiAg
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84eHgvcGljLmMgfCAyIC0tCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9y
bXMvOHh4L3BpYy5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84eHgvcGljLmMKPj4gaW5kZXgg
OGQ1YTI1ZC4uNDQ1M2RmNiAxMDA2NDQKPj4gLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84
eHgvcGljLmMKPj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84eHgvcGljLmMKPj4gQEAg
LTE1Myw5ICsxNTMsNyBAQCBpbnQgbXBjOHh4X3BpY19pbml0KHZvaWQpCj4+ICAgICAgaWYgKG1w
Yzh4eF9waWNfaG9zdCA9PSBOVUxMKSB7Cj4+ICAgICAgICAgIHByaW50ayhLRVJOX0VSUiAiTVBD
OHh4IFBJQzogZmFpbGVkIHRvIGFsbG9jYXRlIGlycSBob3N0IVxuIik7Cj4+ICAgICAgICAgIHJl
dCA9IC1FTk9NRU07Cj4+IC0gICAgICAgIGdvdG8gb3V0Owo+PiAgICAgIH0KPj4gLSAgICByZXR1
cm4gMDsKPiAKPiBJdCdzIGZyYWdpbGUgdG8gcmVseSBvbiByZXQgYmVpbmcgZXF1YWwgdG8gemVy
byBoZXJlLiBJZiB0aGUgY29kZQo+IGZ1cnRoZXIgdXAgaXMgY2hhbmdlZCBpdCdzIGVhc3kgZW5v
dWdoIHRvIG1pc3MgdGhhdCByZXQgaXMgZXhwZWN0ZWQgdG8KPiBiZSB6ZXJvLgo+IAo+IEJldHRl
ciB0byBzZXQgaXQgdG8gemVybyBoZXJlIGV4cGxpY2l0bHksIHRoaXMgaXMgdGhlIHN1Y2Nlc3Mg
cGF0aCBhZnRlcgo+IGFsbCwgZWc6Cj4gCj4gcmV0ID0gMDsKPiAKClRoYW5rIHlvdSBmb3IgeW91
ciBjb21tZW50cy4KSSdsbCBmaXggaXQgc29vbi4KClRoYW5rcyBhbmQgcmVnYXJkcywKV2Vu


--=====_003_next=====--

--=====_001_next=====--

