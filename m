Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3BC73C7C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 07:36:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D706E2064A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 07:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D706E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45k9wr1Jh7zDqLt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 17:36:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45k9v10MQfzDq6l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 17:34:47 +1000 (AEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 8BA30BED63CF384E6B11;
 Wed, 10 Jul 2019 15:34:41 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse-fl1.zte.com.cn with SMTP id x6A7Xinr026714;
 Wed, 10 Jul 2019 15:33:44 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Wed, 10 Jul 2019 15:33:44 +0800 (CST)
Date: Wed, 10 Jul 2019 15:33:44 +0800 (CST)
X-Zmail-TransId: 2b055d2594d8e0b288e8
X-Mailer: Zmail v1.0
Message-ID: <201907101533443009168@zte.com.cn>
In-Reply-To: <3138c2fa-1e99-f672-2108-33dd1cf25ca2@web.de>
References: 1562670768-23178-2-git-send-email-wen.yang99@zte.com.cn,
 3138c2fa-1e99-f672-2108-33dd1cf25ca2@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Subject: =?UTF-8?B?UmU6IFsxLzJdIHBvd2VycGMvODN4eDogZml4IHVzZS1hZnRlci1mcmVlIGluIG1wYzgzMXhfdXNiX2NmZygp?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x6A7Xinr026714
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
Cc: wang.yi59@zte.com.cn, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss@buserror.net, Markus.Elfring@web.de,
 xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn, paulus@samba.org,
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

PiA+IFRoZSBpbW1yX25vZGUgdmFyaWFibGUgaXMgc3RpbGwgYmVpbmcgdXNlZCBhZnRlciB0aGUg
b2Zfbm9kZV9wdXQoKSBjYWxsLAo+ID4gd2hpY2ggbWF5IHJlc3VsdCBpbiB1c2UtYWZ0ZXItZnJl
ZS4KPiAKPiBXYXMgYW55IGtub3duIHNvdXJjZSBjb2RlIGFuYWx5c2lzIHRvb2wgaW52b2x2ZWQg
dG8gcG9pbnQgc3VjaAo+IGEgcXVlc3Rpb25hYmxlIGltcGxlbWVudGF0aW9uIGRldGFpbCBvdXQg
Zm9yIGZ1cnRoZXIgc29mdHdhcmUKPiBkZXZlbG9wbWVudCBjb25zaWRlcmF0aW9ucz8KCkhpIE1h
cmt1cywgCndlIGRldmVsb3BlZCBhIGNvY2NpbmVsbGUgc2NyaXB0IHRvIGRldGVjdCBzdWNoIHBy
b2JsZW1zLiAKVGhpcyBzY3JpcHQgaXMgc3RpbGwgYmVpbmcgaW1wcm92ZWQuCkFmdGVyIGEgcGVy
aW9kIG9mIHRlc3RpbmcsIHdlIHdpbGwgc2VuZCBpdCB0byB0aGUgTE1LTCBtYWlsaW5nIGxpc3Qg
bGF0ZXIuCgotLQpSZWdhcmRzLApXZW4=


--=====_003_next=====--

--=====_001_next=====--

