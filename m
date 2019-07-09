Return-Path: <SRS0=CkO+=VG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF70C606B0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8050C2166E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8050C2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jR2g2sJHzDqB7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 12:23:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.169; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jR0D5HMxzDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 12:21:46 +1000 (AEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 5BA317F284F9B25786FF;
 Tue,  9 Jul 2019 10:21:38 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl1.zte.com.cn with SMTP id x692Jw8x080692;
 Tue, 9 Jul 2019 10:19:58 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp04[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 9 Jul 2019 10:19:58 +0800 (CST)
Date: Tue, 9 Jul 2019 10:19:58 +0800 (CST)
X-Zmail-TransId: 2b065d23f9ce25f25cd5
X-Mailer: Zmail v1.0
Message-ID: <201907091019586328815@zte.com.cn>
In-Reply-To: <99840e11-e0e6-b3f4-e35b-56ef4ec39417@web.de>
References: 1562317084-13140-1-git-send-email-wen.yang99@zte.com.cn,
 99840e11-e0e6-b3f4-e35b-56ef4ec39417@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Subject: =?UTF-8?B?UmU6IHBvd2VycGMvODN4eDogZml4IHVzZS1hZnRlci1mcmVlIG9uIG1wYzgzMXhfdXNiX2NmZygp?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x692Jw8x080692
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
Cc: wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss@buserror.net, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
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

PiA+IFRoZSBucCB2YXJpYWJsZSBpcyBzdGlsbCBiZWluZyB1c2VkIGFmdGVyIHRoZSBvZl9ub2Rl
X3B1dCgpIGNhbGwsCj4gCj4gPiB3aGljaCBtYXkgcmVzdWx0IGluIHVzZS1hZnRlci1mcmVlLgo+
IAo+ID4gV2UgZml4IHRoaXMgaXNzdWUgYnkgY2FsbGluZyBvZl9ub2RlX3B1dCgpIGFmdGVyIHRo
ZSBsYXN0IHVzYWdlLgo+IAo+IAo+IEkgaW1hZ2luZSB0aGF0IHRoaXMgY29tbWl0IGRlc2NyaXB0
aW9uIGNhbiBiZSBpbXByb3ZlZCBhIGJpdCBtb3JlCj4gKGJ5IG1lbnRpb25pbmcgdGhlIGluZmx1
ZW5jZSBvZiDigJxpbW1yX25vZGXigJ0/KS4KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIG9t
aXQgdGhlIHdvcmQg4oCcV2XigJ0gaGVyZT8KPiAKPiAKPiA+IFRoaXMgcGF0YXRjaCBhbHNvIGRv
IHNvbWUgY2xlYW51cC4KPiAKPiAKPiBTaG91bGQgdGhlIHJlbmFtaW5nIG9mIGEganVtcCBsYWJl
bCBiZSBjb250cmlidXRlZCBpbiBhIHNlcGFyYXRlIHVwZGF0ZQo+IHN0ZXAgb2YgYSBzbWFsbCBw
YXRjaCBzZXJpZXMgYmVzaWRlcyBhIHdvcmRpbmcgd2l0aG91dCBhIHR5cG8/CgpUaGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudHMuCldlIHdpbGwgaW1wcm92ZSB0aGUgY29tbWl0IGRlc2NyaXB0aW9u
IGFuZCBzZW5kIHYyIGFzIHNvb24gYXMgcG9zc2libGUuCgotLQpSZWdhcmRzLApXZW4=


--=====_003_next=====--

--=====_001_next=====--

