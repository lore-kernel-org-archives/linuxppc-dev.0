Return-Path: <SRS0=CkO+=VG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382BEC606B0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 01:41:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615672166E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 01:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615672166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jQ5r653XzDq5y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 11:41:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jQ3d1HDxzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 11:39:33 +1000 (AEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id D17BBEBE343DE2102881;
 Tue,  9 Jul 2019 09:39:30 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl1.zte.com.cn with SMTP id x691dGta040307;
 Tue, 9 Jul 2019 09:39:16 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp04[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 9 Jul 2019 09:39:16 +0800 (CST)
Date: Tue, 9 Jul 2019 09:39:16 +0800 (CST)
X-Zmail-TransId: 2b065d23f0441b1d0c7b
X-Mailer: Zmail v1.0
Message-ID: <201907090939164296374@zte.com.cn>
In-Reply-To: <3c1d01ef-5d2a-2ec6-aeeb-b7936515a119@xenosoft.de>
References: 3c1d01ef-5d2a-2ec6-aeeb-b7936515a119@xenosoft.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <chzigotzky@xenosoft.de>
Subject: =?UTF-8?B?UmU6W1BBVENIIHYzXSBjcHVmcmVxL3Bhc2VtaTogZml4IGFuIHVzZS1hZnRlci1mcmVlIGlucGFzX2NwdWZyZXFfY3B1X2luaXQoKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x691dGta040307
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

PiBIZWxsbyBXZW4sCj4gCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+IAo+IERpZCB5b3UgdGVz
dCB5b3VyIHBhdGNoIHdpdGggYSBQLkEuIFNlbWkgYm9hcmQ/Cj4gCgpIZWxsbyBDaHJpc3RpYW4s
IHRoYW5rIHlvdS4KV2UgZG9uJ3QgaGF2ZSBhIFAuQS4gU2VtaSBib2FyZCB5ZXQsIHNvIHdlIGRp
ZG4ndCB0ZXN0IGl0LgpJZiB5b3UgaGF2ZSBzdWNoIGEgYm9hcmQsIGNvdWxkIHlvdSBwbGVhc2Ug
a2luZGx5IGhlbHAgdG8gdGVzdCBpdD8KCi0tClRoYW5rcyBhbmQgcmVnYXJkcywKV2Vu


--=====_003_next=====--

--=====_001_next=====--

