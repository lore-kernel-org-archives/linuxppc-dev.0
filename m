Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA684C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 07:09:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A72218FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 07:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A72218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RZSM3BVxzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 18:09:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.169; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RZPv67b0zDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 18:06:57 +1100 (AEDT)
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
 by Forcepoint Email with ESMTPS id 00EA11FF9EFA944D04F4;
 Sat, 29 Dec 2018 15:06:53 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse02.zte.com.cn with SMTP id wBT76l9W010595;
 Sat, 29 Dec 2018 15:06:47 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp04[null]) by mapi (Zmail) with MAPI id mid14;
 Sat, 29 Dec 2018 15:06:49 +0800 (CST)
Date: Sat, 29 Dec 2018 15:06:49 +0800 (CST)
X-Zmail-TransId: 2b065c271d09147eeb5d
X-Mailer: Zmail v1.0
Message-ID: <201812291506496295466@zte.com.cn>
In-Reply-To: <20181228.211053.848330303302862567.davem@davemloft.net>
References: 1545812789-77690-1-git-send-email-peng.hao2@zte.com.cn,
 20181228.211053.848330303302862567.davem@davemloft.net
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <davem@davemloft.net>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10gc29jL2ZzbC9xZTogZml4IGVyciBoYW5kbGluZyBvZiB1Y2Nfb2ZfcGFyc2VfdGRt?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn wBT76l9W010595
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
Cc: peng.hao2@zte.com.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, julia.lawall@lip6.fr, linuxppc-dev@lists.ozlabs.org,
 qiang.zhao@nxp.com
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

SGkgRGF2aWTvvIwKVGhhbmsgeW91LCB3ZSdsbCBmaXggaXQgc29vbi4KCkJlc3Qgd2lzaGVzLAog
IFdlbgotLS0tLS0tLS0tLS0tLS0tLS1PcmlnaW5hbCBNYWlsLS0tLS0tLS0tLS0tLS0tLS0tClNl
bmRlcjogRGF2aWRNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+ClRvOiBwZW5nIGhhbzEwMDk2
NzQyOwpDQzogcWlhbmcuemhhb0BueHAuY29tIDxxaWFuZy56aGFvQG54cC5jb20+bGVveWFuZy5s
aUBueHAuY29tIDxsZW95YW5nLmxpQG54cC5jb20+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz53ZW4geWFuZzEwMTU2MzE0O2p1bGlhLmxh
d2FsbEBsaXA2LmZyIDxqdWxpYS5sYXdhbGxAbGlwNi5mcj5uZXRkZXZAdmdlci5rZXJuZWwub3Jn
IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPmxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnIDxs
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZz4KRGF0ZTogMjAxOC8xMi8yOSAxMzoxMQpTdWJq
ZWN0OiBSZTogW1BBVENIIHYzXSBzb2MvZnNsL3FlOiBmaXggZXJyIGhhbmRsaW5nIG9mIHVjY19v
Zl9wYXJzZV90ZG0KRnJvbTogUGVuZyBIYW8gPHBlbmcuaGFvMkB6dGUuY29tLmNuPgpEYXRlOiBX
ZWQsIDI2IERlYyAyMDE4IDE2OjI2OjI5ICswODAwCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93YW4vZnNsX3VjY19oZGxjLmMgYi9kcml2ZXJzL25ldC93YW4vZnNsX3VjY19oZGxjLmMKPiBp
bmRleCA4MzlmYTc3Li44Y2U0OTIxZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC93YW4vZnNs
X3VjY19oZGxjLmMKPiArKysgYi9kcml2ZXJzL25ldC93YW4vZnNsX3VjY19oZGxjLmMKPiBAQCAt
MTA1Nyw2ICsxMDU3LDI3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgdWhk
bGNfb3BzID0gewo+ICAgICAgLm5kb190eF90aW1lb3V0ICAgID0gdWhkbGNfdHhfdGltZW91dCwK
PiAgfTsKPgo+ICtzdGF0aWMgaW50IHVjY19nZXRfcmVzb3VyY2VfYnlfbm9kZW5hbWUoY2hhciAq
bmFtZSwgc3RydWN0IHJlc291cmNlICpyZXMpCj4gK3sKLi4uCj4gKyAgICByZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOwo+ICsgICAgcmV0dXJuIDA7
CgpUaGlzIGFzc2lnbm1lbnQgdG8gJ3JlcycgZG9lc24ndCBkbyB3aGF0IHlvdSB0aGluayBpdCBk
b2VzLiAgVGhlIGNhbGxlciBuZXZlcgpzZWVzIHRoZSB2YWx1ZSB5b3UgY29tcHV0ZS4=


--=====_003_next=====--

--=====_001_next=====--

