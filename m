Return-Path: <SRS0=eboA=GB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5384AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D49207CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D49207CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=git.icu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4pDz01WszDqHY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Dec 2020 19:56:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=git.icu
 (client-ip=5.45.198.245; helo=forward400j.mail.yandex.net;
 envelope-from=shawn@git.icu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=git.icu
Received: from forward400j.mail.yandex.net (forward400j.mail.yandex.net
 [5.45.198.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4pBp2JYRzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Dec 2020 19:54:41 +1100 (AEDT)
Received: from iva6-862b1c8daa54.qloud-c.yandex.net
 (iva6-862b1c8daa54.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:6107:0:640:862b:1c8d])
 by forward400j.mail.yandex.net (Yandex) with ESMTP id 6E9626E0F2A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Dec 2020 11:54:17 +0300 (MSK)
Received: from localhost (localhost [::1])
 by iva6-862b1c8daa54.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 X7OgoWHA1q-sGEKjZrq; Tue, 29 Dec 2020 11:54:16 +0300
Authentication-Results: iva6-862b1c8daa54.qloud-c.yandex.net; dkim=pass
Received: by iva2-957330f6752d.qloud-c.yandex.net with HTTP;
 Tue, 29 Dec 2020 11:54:16 +0300
From: Shawn Landden <shawn@git.icu>
To: linuxppc-dev@lists.ozlabs.org
Subject: unsubscribe
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 29 Dec 2020 03:54:16 -0500
Message-Id: <1655131609232036@mail.yandex.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



-- 
Shawn Landden

