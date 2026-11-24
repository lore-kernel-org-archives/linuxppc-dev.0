Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D79606A68D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=D/uKJ+0u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYl655GY0z3bw9;
	Wed, 25 Nov 2026 01:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=160.236.53.106
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529325;
	cv=none; b=DWWL/qOXeTfp3l17GQuTYZ+QjYXPjvE+EDRF1Dynq5YNhisxEXjukSaGIhGNhUKKAzDIUDWQs0st1/pTFNSXqtVMSX+fhnyBtIrUiUg+SDq0MGN6nNDVU6ommRbmx3w7GhXBwbKqZ9lNoRed36NteVJuHc350hx+LVEJ6IGKaHaxGVS5yV7jGyUxpXdIchuV8dS/Haym8hB4/DyYQnj3nQ6Q3RyOpFAxKhRmMQ/54oolJHmV4p6fIZwZOoTOQIZRP9o0ByHkhZtpqPsEcWv05BQhT1lTq23KiF5m5hlntCeXVdYPxHZ8ZvxIykNniE+6tmk0vs051GPo9EI8IPjqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529325; c=relaxed/relaxed;
	bh=HI3+zRoML73VqUDFgUkem+fi9Zk9wVZtNVO6T+O4umo=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=DEYwspfSivja1Z2fnkHc3LddWnCLwyjgv2DXJWYpOLOODjovwQLh9PhU0b7HxciBpivoqkijR2vQ4OGoz5/0R0YmIQDDPd29uED+nlymWT+pYU52r3RtkiIjCJa8VyB8lNa2nT5fAK65vLHiPRtTQ9lzM15KBrFsX4NGrDNQf6to/7XSzyvmikC5rzrVPghdcHN7RsCzQ1py/G+pSccKHiLfOCtq9mysjmd8JiKTMhUMH5oOH89tRFBo3K36t9o5JVjnqu1kVoNBYwyMuowvIdCDFaNMFXc8inoiJhuVBVCJIDrVv81wAKywDg7A3TzRD/yfKv6gBJuC0ymmYWjXRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=D/uKJ+0u; dkim-atps=neutral; spf=pass (client-ip=160.236.53.106; helo=mail-m16023653106.xmail.ntesmail.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=D/uKJ+0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=160.236.53.106; helo=mail-m16023653106.xmail.ntesmail.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 304 seconds by postgrey-1.37 at boromir; Wed, 25 Nov 2026 01:08:42 AEDT
Received: from mail-m16023653106.xmail.ntesmail.com (mail-m16023653106.xmail.ntesmail.com [160.236.53.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYl626Khkz3bvX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 01:08:42 +1100 (AEDT)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ALsAxABOLObQtvY4cNh8h4ri.3.1795529011462.Hmail.202321181@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	stable@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAxLzJdIHVzYjogZ2FkZ2V0OiBmc2xfdWRjOiBGaXggcG90ZW50aWFsIHVzZS1hZnRlci1mcmVlIGR1cmluZyByZW1vdmFs?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <2026112015-lumber-flyer-d8f6@gregkh>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn> <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn> <2026112015-lumber-flyer-d8f6@gregkh>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Tue, 24 Nov 2026 22:03:31 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Tue, 24 Nov 2026 22:03:31 +0800 (GMT+08:00)
X-HM-Tid: 0aa20dde1987d0cdkusyef3b67ad248cc
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VetZ+Wq0Te/EdHEVk+2W3XygE0t2b+veD5v+x2w+urvHGDFo8E
	1w4QTE3rOb9NJ317UcvoSbBVgCnZeqAYiPp08=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTktDVh8eSU5PQhpPGk8dSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=D/uKJ+0uwPuQOme/sVt2TP4G6VPwy62d+GMDXMtIrTTShkyH0r3pSRn8f/YzLIMUeoHDoKJHy2pq070Mr0I4lxhjimhb52/HJvxpCMb1U9efMRFuT/rsq1K7a/QiYST4zIKCVKvR8SUDuWv24uaDQGMhBx0TLMT73Dr5iNTsogI=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=HI3+zRoML73VqUDFgUkem+fi9Zk9wVZtNVO6T+O4umo=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CgoKSGkgR3JlZywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCgoKRnJvbTogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KRGF0ZTogMjAyNi0xMS0yMCAyMDox
MDo1NApUbzogIEd1YW5nc2h1byBMaSA8bGlndWFuZ3NodW9AbWFpbC5zZHUuZWR1LmNuPgpDYzog
IE5laWxsIEthcHJvbiA8bmthcHJvbkBnb29nbGUuY29tPixsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsbGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmcsc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdXNi
OiBnYWRnZXQ6IGZzbF91ZGM6IEZpeCBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUgZHVyaW5nIHJl
bW92YWw+T24gV2VkLCBOb3YgMTgsIDIwMjYgYXQgMTA6MTA6NTNQTSArMDgwMCwgR3VhbmdzaHVv
IExpIHdyb3RlOgo+PiB1c2JfZGVsX2dhZGdldF91ZGMoKSBjYW4gZHJvcCB0aGUgbGFzdCBnYWRn
ZXQgZGV2aWNlIHJlZmVyZW5jZSBhbmQgY2FsbAo+PiBmc2xfdWRjX3JlbGVhc2UoKSwgd2hpY2gg
ZnJlZXMgdWRjX2NvbnRyb2xsZXIuIFRoZSByZW1haW5pbmcgcmVtb3ZlIHBhdGgKPj4gdGhlbiBk
ZXJlZmVyZW5jZXMgaXQgdG8gcmVsZWFzZSBpdHMgcmVxdWVzdHMsIGVuZHBvaW50cyBhbmQgRE1B
IHBvb2wuCj4+IAo+PiBIb2xkIGEgZ2FkZ2V0IGRldmljZSByZWZlcmVuY2UgdW50aWwgdGhpcyBj
bGVhbnVwIGhhcyBmaW5pc2hlZC4KPj4gCj4+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIGJ5IG91ciBz
dGF0aWMgYW5hbHlzaXMgdG9vbCB1bmRlciBkZXZlbG9wbWVudC4KPj4gCj4+IEZpeGVzOiBlYWIz
NWM0ZTZkOTUgKCJ1c2I6IGdhZGdldDogZnNsX3VkY19jb3JlOiBsZXQgdWRjLWNvcmUgbWFuYWdl
IGdhZGdldC0+ZGV2IikKPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9m
Zi1ieTogR3VhbmdzaHVvIExpIDxsaWd1YW5nc2h1b0BtYWlsLnNkdS5lZHUuY24+Cj4+IC0tLQo+
PiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xfdWRjX2NvcmUuYyB8IDIgKysKPj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2ZzbF91ZGNfY29yZS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xf
dWRjX2NvcmUuYwo+PiBpbmRleCA4NzhkNzBiNTU1MzAuLjlkOWQyMTY0YzViZiAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xfdWRjX2NvcmUuYwo+PiArKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2ZzbF91ZGNfY29yZS5jCj4+IEBAIC0yNTM3LDYgKzI1MzcsNyBA
QCBzdGF0aWMgdm9pZCBmc2xfdWRjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQo+PiAgCURFQ0xBUkVfQ09NUExFVElPTl9PTlNUQUNLKGRvbmUpOwo+PiAgCj4+ICAJdWRjX2Nv
bnRyb2xsZXItPmRvbmUgPSAmZG9uZTsKPj4gKwlnZXRfZGV2aWNlKCZ1ZGNfY29udHJvbGxlci0+
Z2FkZ2V0LmRldik7Cj4KPlRoaXMgZmVlbHMgd3JvbmcsIHdoeSBhcmUgeW91IG5lZWRpbmcgYSBm
YWtlIHJlZmVyZW5jZSBoZXJlPwo+Cj4+ICAJdXNiX2RlbF9nYWRnZXRfdWRjKCZ1ZGNfY29udHJv
bGxlci0+Z2FkZ2V0KTsKPgo+VGhpcyBpcyB3aGVyZSBpdCBzaG91bGQgYWxsIGdvIGF3YXkuICBJ
ZiBub3QsIHRoZW4gcmVvcmRlciB0aGUgY29kZQo+cHJvcGVybHkuCj4KCkkgdW5kZXJzdGFuZCB0
aGF0IHRoZSBkcml2ZXIncyBjbGVhbnVwIHNob3VsZCBwcmVjZWRlIHRoZSBmaW5hbCBnYWRnZXQK
cmVsZWFzZSwgd2l0aG91dCBhZGRpbmcgYW5vdGhlciByZWZlcmVuY2UuIHVzYl9kZWxfZ2FkZ2V0
X3VkYygpIGNvbWJpbmVzCnVucmVnaXN0ZXJpbmcgdGhlIGdhZGdldCB3aXRoIHRoYXQgZmluYWwg
cHV0LgoKV291bGQgdXNpbmcgdXNiX2RlbF9nYWRnZXQoKSBmaXJzdCwgdGhlbiBjbGVhbmluZyB1
cCB0aGUgZHJpdmVyIHJlc291cmNlcwpiZWZvcmUgdXNiX3B1dF9nYWRnZXQoKSwgYmUgdGhlIG9y
ZGVyaW5nIHlvdSBtZWFudCBmb3IgdjI/CgpUaGFua3MsCkd1YW5nc2h1bwo=

