Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA635C76188
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 05:57:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C4D2085A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 05:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C4D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qgJZ707NzDqZn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 15:57:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qgD300XzzDqvL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 15:53:36 +1000 (AEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id EBFF080F49D5410EE23C;
 Fri, 19 Jul 2019 13:53:32 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse-fl2.zte.com.cn with SMTP id x6J5rIow024131;
 Fri, 19 Jul 2019 13:53:18 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Fri, 19 Jul 2019 13:53:18 +0800 (CST)
Date: Fri, 19 Jul 2019 13:53:18 +0800 (CST)
X-Zmail-TransId: 2b055d315acebc291465
X-Mailer: Zmail v1.0
Message-ID: <201907191353187645082@zte.com.cn>
In-Reply-To: <ca8781a6-438e-b69b-5d55-7267f2106f79@xenosoft.de>
References: 201907090939164296374@zte.com.cn,
 ca8781a6-438e-b69b-5d55-7267f2106f79@xenosoft.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <chzigotzky@xenosoft.de>
Subject: =?UTF-8?B?UmU6W1BBVENIIHY3XSBjcHVmcmVxL3Bhc2VtaTogZml4IGFuIHVzZS1hZnRlci1mcmVlaW5wYXNfY3B1ZnJlcV9jcHVfaW5pdCgp?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x6J5rIow024131
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
Cc: linuxppc-dev@lists.ozlabs.org
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

Pj4+IEhlbGxvIFdlbiwKPj4+Cj4+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghCj4+Pgo+Pj4gRGlk
IHlvdSB0ZXN0IHlvdXIgcGF0Y2ggd2l0aCBhIFAuQS4gU2VtaSBib2FyZD8KPj4+Cj4+IEhlbGxv
IENocmlzdGlhbiwgdGhhbmsgeW91Lgo+PiBXZSBkb24ndCBoYXZlIGEgUC5BLiBTZW1pIGJvYXJk
IHlldCwgc28gd2UgZGlkbid0IHRlc3QgaXQuCj4+IElmIHlvdSBoYXZlIHN1Y2ggYSBib2FyZCwg
Y291bGQgeW91IHBsZWFzZSBraW5kbHkgaGVscCB0byB0ZXN0IGl0Pwo+Pgo+PiAtLQo+PiBUaGFu
a3MgYW5kIHJlZ2FyZHMsCj4+IFdlbgo+IAo+IEhlbGxvIFdlbiwKPiAKPiBJIHN1Y2Nlc3NmdWxs
eSB0ZXN0ZWQgeW91ciBwYXNlbWkgY3B1ZnJlcSBtb2RpZmljYXRpb25zIHdpdGggbXkgUC5BLgo+
IFNlbWkgYm9hcmQgWzFdIHRvZGF5Lgo+IAo+IEZpcnN0IEkgcGF0Y2hlZCB0aGUgbGF0ZXN0IEdp
dCBrZXJuZWwgd2l0aCBWaXJlc2ggS3VtYXIncyBwYXRjaCBbMl0uCj4gQWZ0ZXIgdGhhdCBJIHdh
cyBhYmxlIHRvIHBhdGNoIHRoZSBsYXRlc3QgR2l0IGtlcm5lbCB3aXRoIHlvdXIgdjcgcGF0Y2gg
WzNdLgo+IAo+IFRoZW4gdGhlIGtlcm5lbCBjb21waWxlZCB3aXRob3V0IGFueSBlcnJvcnMuCj4g
Cj4gQWZ0ZXJ3YXJkcyBJIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgdGhlIG5ldyBHaXQga2VybmVsIHdp
dGggc29tZSBjcHVmcmVxCj4gZ292ZXJub3JzIG9uIG9wZW5TVVNFIFR1bWJsZXdlZWQgMjAxOTA1
MjEgUG93ZXJQQzY0IFs0XSBhbmQgb24gdWJ1bnR1Cj4gTUFURSAxNi4wNC42IExUUyBQb3dlclBD
MzIuCj4gCj4gVGhhbmtzIGEgbG90IGZvciB5b3VyIHdvcmshCj4gCj4gVGVzdGVkLWJ5OiBDaHJp
c3RpYW4gWmlnb3R6a3kgPGNoemlnb3R6a3lAeGVub3NvZnQuZGU+Cj4gCj4gQ2hlZXJzLAo+IENo
cmlzdGlhbgoKVGhhbmsgeW91IHZlcnkgbXVjaCEKLS0KQ2hlZXJzLApXZW4KCj4gWzFdIGh0dHBz
Oi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0FtaWdhT25lX1gxMDAwCj4gWzJdCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9lZThjZjVmYjRiNGEwMWZkZjkxOTkwMzdmZjZkODM1YjkzNWNm
ZDEzLjE1NjI5MDI4NzcuZ2l0LnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnLyNaMzBkcml2ZXJzOmNw
dWZyZXE6cGFzZW1pLWNwdWZyZXEuYwo+IFszXSBodHRwczovL2xpc3RzLm96bGFicy5vcmcvcGlw
ZXJtYWlsL2xpbnV4cHBjLWRldi8yMDE5LUp1bHkvMTkzNzM1Lmh0bWwKPiBbNF0gU2NyZWVuc2hv
dHM6Cj4gaHR0cHM6Ly9pLnBpbmltZy5jb20vb3JpZ2luYWxzLzM3LzY2LzkzLzM3NjY5MzA2Y2Jj
OTA5YTlkNzkyNzBhODQ5ZDE4YWE2LnBuZwo+IGFuZAo+IGh0dHBzOi8vaS5waW5pbWcuY29tL29y
aWdpbmFscy9mZS9mOC9iZi9mZWY4YmZjOTBkOTViNWFlOWNmMzFlMTc1ZThiYTJkYS5wbmc=


--=====_003_next=====--

--=====_001_next=====--

