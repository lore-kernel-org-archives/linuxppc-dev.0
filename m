Return-Path: <SRS0=4/q6=6I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB5C2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 06:50:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B9B2166E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 06:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B9B2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 497lCx66p6zDrCX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 16:50:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=115.236.127.108;
 helo=mail-m127108.qiye.163.com; envelope-from=wenhu.wang@vivo.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
Received: from mail-m127108.qiye.163.com (mail-m127108.qiye.163.com
 [115.236.127.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 497l9r4qWZzDrB8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2020 16:48:04 +1000 (AEST)
Received: from vivo.com (wm-13.qy.internal [127.0.0.1])
 by mail-m127108.qiye.163.com (Hmail) with ESMTP id 6E3FB842298;
 Fri, 24 Apr 2020 14:47:54 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APcAywCbCKy-qoRJBcISMqo3.3.1587710874432.Hmail.wenhu.wang@vivo.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Myw0LzVdIG1pc2M6IHNyYW1fZHluYW1pYyBmb3IgdXNlciBsZXZlbCBTUkFNIGFjY2Vzcw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <6675dd9d-43be-6451-88a9-02d2c52c7d3a@c-s.fr>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail (
 [127.0.0.1] ) ; Fri, 24 Apr 2020 14:47:54 +0800 (GMT+08:00)
From: =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date: Fri, 24 Apr 2020 14:47:54 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNSktLS0tKSEhOSk9PWVdZKFlBSE
 83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMT0tJT0xNS0lDN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6Kxg6Agw4GTgwAlYKFCkxORgyKDYKFEhVSFVKTkNMTEpLQ0xNTktDVTMWGhIXVQweFRMOVQwa
 FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQUhNSUg3Bg++
X-HM-Tid: 0a71aaf1535d986ckuuu6e3fb842298
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
Cc: robh@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, oss@buserror.net, kernel@vivo.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3JhbV9keW5hbWljLmggYi9pbmNsdWRlL2xp
bnV4L3NyYW1fZHluYW1pYy5oCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAw
MDAwMDAwMC4uYzc3ZTllN2IxMTUxCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9zcmFtX2R5bmFtaWMuaAo+PiBAQCAtMCwwICsxLDIzIEBACj4+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLwo+PiArI2lmbmRlZiBfX1NSQU1fRFlOQU1JQ19ICj4+
ICsjZGVmaW5lIF9fU1JBTV9EWU5BTUlDX0gKPj4gKwo+PiArc3RydWN0IHNyYW1fYXBpIHsKPj4g
Kwljb25zdCBjaGFyCSpuYW1lOwo+PiArCXN0cnVjdCBzcmFtX2RldmljZSAqc2RldjsKPj4gKwl2
b2lkICooKmFsbG9jKShfX3UzMiBzaXplLCBwaHlzX2FkZHJfdCAqcGh5cywgX191MzIgYWxpZ24p
Owo+PiArCXZvaWQgKCpmcmVlKSh2b2lkICpwdHIpOwo+PiArfTsKPj4gKwo+PiArZXh0ZXJuIGlu
dCBfX211c3RfY2hlY2sKPj4gKwlfX3NyYW1fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBtb2R1bGUg
Km93bmVyLAo+PiArCQkJICAgICAgIHN0cnVjdCBkZXZpY2UgKnBhcmVudCwKPj4gKwkJCSAgICAg
ICBzdHJ1Y3Qgc3JhbV9hcGkgKnNhKTsKPgo+J2V4dGVybicga2V5d29yZCBpcyB1c2VsZXNzIGhl
cmUsIHJlbW92ZSBpdCAoY2hlY2twYXRjaCAtLXN0cmljdCB3aWxsIAo+bGlrZWx5IHRlbGwgeW91
IHRoZSBzYW1lKQo+Cj4+ICsKPj4gKy8qIFVzZSBhIGRlZmluZSB0byBhdm9pZCBpbmNsdWRlIGNo
YWluaW5nIHRvIGdldCBUSElTX01PRFVMRSAqLwo+PiArI2RlZmluZSBzcmFtX3JlZ2lzdGVyX2Rl
dmljZShwYXJlbnQsIHNhKSBcCj4+ICsJX19zcmFtX3JlZ2lzdGVyX2RldmljZShUSElTX01PRFVM
RSwgcGFyZW50LCBzYSkKPj4gKwo+PiArZXh0ZXJuIHZvaWQgc3JhbV91bnJlZ2lzdGVyX2Rldmlj
ZShzdHJ1Y3Qgc3JhbV9hcGkgKnNhKTsKPgo+U2FtZSwgbm8gJ2V4dGVybicgcGxlYXNlLgo+CgpU
aGFua3MsIEkgd2lsbCByZW1vdmUgdGhlbSBpbiBwYXRjaCB2NC4gQW5kIGNoZWNrcGF0Y2ggd2l0
aCAtLXN0cmljdCB3aWxsIGJlIHByZWZlcmVkLgoKV2VuaHUNCg0K
