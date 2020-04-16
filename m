Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C99C2BB85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 09:32:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DA521BE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 09:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DA521BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492vBb3LMszDrRS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 19:32:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=123.58.177.142; helo=m142-177.yeah.net;
 envelope-from=wenhu.wang@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
Received: from m142-177.yeah.net (m142-177.yeah.net [123.58.177.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492v7t55flzDrRH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 19:29:41 +1000 (AEST)
Received: from vivo.com (localhost [127.0.0.1])
 by m142-177.yeah.net (Hmail) with ESMTP id A6E7D644350;
 Thu, 16 Apr 2020 17:29:29 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIgAKQBlCIqtPx5U5P0kFqpr.3.1587029369636.Hmail.wenhu.wang@vivo.com>
To: Wang Wenhu <wenhu.wang@vivo.com>
Subject: =?UTF-8?B?UmU6W1BBVENIIHYzLDAvNF0gZHJpdmVyczogdWlvOiBuZXcgZHJpdmVyIHVpb19mc2xfODV4eF9jYWNoZV9zcmFt?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <20200416074918.3617-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail (
 [127.0.0.1] ) ; Thu, 16 Apr 2020 17:29:29 +0800 (GMT+08:00)
From: =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date: Thu, 16 Apr 2020 17:29:29 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVJQkJLS0tJTUhJSk9KSllXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSU1KTUxCTU1PN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6Mhw6MCo5FzgyCg8rA04uTitLED0KCwlVSFVKTkNMS0lCSExKTE9DVTMWGhIXVQweFRMOVQwa
 FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQU5JTEI3Bg++
X-HM-Tid: 0a718252635a6473kursa6e7d644350
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, oss@buserror.net,
 kernel@vivo.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGksClNlZW1zIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoZSBzZXJ2ZXIgdGhhdCBt
dWx0aXBsZSBkdW1wbGljYXRpb25zCm9mIHRoZSB2MyBwYXRjaGVzIHdlcmUgc2VudCBvdXQsIHBs
ZWFzZSBpZ25vcmUgdGhlIHJlc3QgYW5kIHRha2UgdGhpcyBuZXdlc3QKc2VyaWVzIGFzIGZvcm1h
bCBjb3VudC4KClRoYW5rcywKV2VuaHUKCkZyb206IFdhbmcgV2VuaHUgPHdlbmh1LndhbmdAdml2
by5jb20+CkRhdGU6IDIwMjAtMDQtMTYgMTU6NDk6MTQKVG86ICBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9zc0BidXNlcnJvci5uZXQsY2hy
aXN0b3BoZS5sZXJveUBjLXMuZnIsbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKQ2M6ICBr
ZXJuZWxAdml2by5jb20sV2FuZyBXZW5odSA8d2VuaHUud2FuZ0B2aXZvLmNvbT4KU3ViamVjdDog
W1BBVENIIHYzLDAvNF0gZHJpdmVyczogdWlvOiBuZXcgZHJpdmVyIHVpb19mc2xfODV4eF9jYWNo
ZV9zcmFtPlRoaXMgc2VyaWVzIGFkZCBhIG5ldyB1aW8gZHJpdmVyIGZvciBmcmVlc2NhbGUgODV4
eCBwbGF0Zm9ybXMgdG8KPmFjY2VzcyB0aGUgQ2FjaGUtU3JhbSBmb3JtIHVzZXIgbGV2ZWwuIFRo
aXMgaXMgZXh0cmVtZWx5IGhlbHBmdWwKPmZvciB0aGUgdXNlci1zcGFjZSBhcHBsaWNhdGlvbnMg
dGhhdCByZXF1aXJlIGhpZ2ggcGVyZm9ybWFuY2UgbWVtb3J5Cj5hY2Nlc3Nlcy4KPgo+SXQgZml4
ZXMgdGhlIGNvbXBpbGUgZXJyb3JzIGFuZCB3YXJuaW5nIG9mIHRoZSBoYXJkd2FyZSBsZXZlbCBk
cml2ZXJzCj5hbmQgaW1wbGVtZW50cyB0aGUgdWlvIGRyaXZlciBpbiB1aW9fZnNsXzg1eHhfY2Fj
aGVfc3JhbS5jLgo+Cj5DaGFuZ2VzIHNpbmNlIHYxOgo+ICogQWRkcmVzc2VkIGNvbW1lbnRzIGZy
b20gR3JlZyBLLUgKPiAqIE1vdmVkIGtmcmVlKGluZm8tPm5hbWUpIGludG8gdWlvX2luZm9fZnJl
ZV9pbnRlcm5hbCgpCj4KPkNoYW5nZXMgc2luY2UgdjI6Cj4gKiBEcm9wIHRoZSBwYXRjaCB0aGF0
IG1vZGlmaWVzIEtjb25maWdzIG9mIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMKPiAgIGFuZCBtb2Rp
ZmllZCB0aGUgc2VxdWVuY2Ugb2YgcGF0Y2hlczoKPiAgICAwMTpkcm9wcGVkLCAwMi0+MDMsIDAz
LT4wMiwgMDQtPjAxLCAwNS0+MDQKPiAqIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIEdyZWcsIFNj
b3R0IGFuZCBDaHJpc3RvcGhlCj4gKiBVc2UgInVpb21lbS0+aW50ZXJuYWxfYWRkciIgYXMgaWYg
Y29uZGl0aW9uIGZvciBzcmFtIG1lbW9yeSBmcmVlLAo+ICAgYW5kIG1lbXNldCB0aGUgdWlvbWVt
IGVudHJ5Cj4gKiBNb2RpZmllZCBvZl9tYXRjaF90YWJsZSBtYWtlIHRoZSBkcml2ZXIgYXBhcnQg
ZnJvbSBDYWNoZS1TcmFtIEhXIGluZm8KPiAgIHdoaWNoIGJlbG9uZyB0byB0aGUgSFcgbGV2ZWwg
ZHJpdmVyIGZzbF84NXh4X2NhY2hlX3NyYW0gdG8gbWF0Y2gKPiAqIFVzZSByb3VuZHVwX3Bvd19v
Zl90d28gZm9yIGFsaWduIGNhbGMocmVhbGx5IGxlYXJuZWQgYSBsb3QgZnJvbSBDaHJpc3RvcGhl
KQo+ICogUmVtb3ZlIHVzZWxlc3MgY2xlYXIgYmxvY2sgb2YgdWlvbWVtIGVudHJpZXMuCj4gKiBV
c2UgVUlPX0lORk9fVkVSIG1pY3JvIGZvciBpbmZvLT52ZXJzaW9uLCBhbmQgZGVmaW5lIGl0IGFz
Cj4gICAiZGV2aWNldHJlZSxwc2V1ZG8iLCBtZWFuaW5nIHRoaXMgaXMgcHNldWRvIGRldmljZSBh
bmQgcHJvYmVkIGZyb20KPiAgIGRldmljZSB0cmVlIGNvbmZpZ3VyYXRpb24KPiAqIFNlbGVjdCBG
U0xfODVYWF9DQUNIRV9TUkFNIHJhdGhlciB0aGFuIGRlcGVuZHMgb24gaXQKPgo+V2FuZyBXZW5o
dSAoNCk6Cj4gIHBvd2VycGM6IHN5c2RldjogZml4IGNvbXBpbGUgZXJyb3IgZm9yIGZzbF84NXh4
X2wyY3Rscgo+ICBwb3dlcnBjOiBzeXNkZXY6IGZpeCBjb21waWxlIGVycm9yIGZvciBmc2xfODV4
eF9jYWNoZV9zcmFtCj4gIHBvd2VycGM6IHN5c2RldjogZml4IGNvbXBpbGUgd2FybmluZyBmb3Ig
ZnNsXzg1eHhfY2FjaGVfc3JhbQo+ICBkcml2ZXJzOiB1aW86IG5ldyBkcml2ZXIgZm9yIGZzbF84
NXh4X2NhY2hlX3NyYW0KPgo+IGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfY2FjaGVfc3Jh
bS5jIHwgICAzICstCj4gYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfODV4eF9sMmN0bHIuYyAgICAg
fCAgIDEgKwo+IGRyaXZlcnMvdWlvL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICA5
ICsrCj4gZHJpdmVycy91aW8vTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+
IGRyaXZlcnMvdWlvL3Vpb19mc2xfODV4eF9jYWNoZV9zcmFtLmMgICAgIHwgMTU4ICsrKysrKysr
KysrKysrKysrKysrKysKPiA1IGZpbGVzIGNoYW5nZWQsIDE3MSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdWlvL3Vpb19mc2xfODV4eF9j
YWNoZV9zcmFtLmMKPgo+LS0gCj4yLjE3LjEKPgoNCg0K
