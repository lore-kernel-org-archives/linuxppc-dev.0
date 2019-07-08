Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CCC48BE7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 07:06:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8E020844
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 07:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8E020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hxMQ3XyszDqXK
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 17:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.169; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hxKP3CkgzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 17:04:56 +1000 (AEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id BD9B29C5E2C3F67267AD;
 Mon,  8 Jul 2019 15:04:49 +0800 (CST)
Received: from kjyxapp01.zte.com.cn ([10.30.12.200])
 by mse-fl1.zte.com.cn with SMTP id x6873vhu077248;
 Mon, 8 Jul 2019 15:03:57 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp04[null]) by mapi (Zmail) with MAPI id mid14;
 Mon, 8 Jul 2019 15:03:57 +0800 (CST)
Date: Mon, 8 Jul 2019 15:03:57 +0800 (CST)
X-Zmail-TransId: 2b065d22eadd679e0530
X-Mailer: Zmail v1.0
Message-ID: <201907081503576413750@zte.com.cn>
In-Reply-To: <20190708062708.5zufqsmgso436idn@vireshk-i7>
References: 1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn,
 20190708062708.5zufqsmgso436idn@vireshk-i7
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <viresh.kumar@linaro.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gY3B1ZnJlcS9wYXNlbWk6IGZpeCBhbiB1c2UtYWZ0ZXItZnJlZSBpbnBhc19jcHVmcmVxX2NwdV9pbml0KCk=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x6873vhu077248
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
Cc: wang.yi59@zte.com.cn, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
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

PiA+IFRoZSBjcHUgdmFyaWFibGUgaXMgc3RpbGwgYmVpbmcgdXNlZCBpbiB0aGUgb2ZfZ2V0X3By
b3BlcnR5KCkgY2FsbAo+ID4gYWZ0ZXIgdGhlIG9mX25vZGVfcHV0KCkgY2FsbCwgd2hpY2ggbWF5
IHJlc3VsdCBpbiB1c2UtYWZ0ZXItZnJlZS4KPiA+Cj4gPiBGaXhlczogYTlhY2MyNmI3NWYgKCJj
cHVmcmVxL3Bhc2VtaTogZml4IHBvc3NpYmxlIG9iamVjdCByZWZlcmVuY2UgbGVhayIpCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZW4gWWFuZyA8d2VuLnlhbmc5OUB6dGUuY29tLmNuPgo+ID4gQ2M6ICJS
YWZhZWwgSi4gV3lzb2NraSIgPHJqd0Byand5c29ja2kubmV0Pgo+ID4gQ2M6IFZpcmVzaCBLdW1h
ciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Cj4gPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcKPiA+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcKPiA+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiAtLS0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvcGFzZW1p
LWNwdWZyZXEuYyB8IDEwICsrKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IEkgd2lsbCBzdWdnZXN0IHNvbWUgY2hhbmdlcyBo
ZXJlLgoKSGVsbG8gdmlyZXNoLCB0aGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCldlIHdpbGwg
bWFrZSBjaGFuZ2VzIGFzIHNvb24gYXMgcG9zc2libGUuCgotLQpUaGFua3MgYW5kIHJlZ2FyZHMs
Cldlbg==


--=====_003_next=====--

--=====_001_next=====--

