Return-Path: <SRS0=4INi=FZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7768C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 07:35:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978FC22BF5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 07:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978FC22BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=git.icu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CzrqR72QtzDqHL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 18:35:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=git.icu
 (client-ip=5.45.198.240; helo=forward100j.mail.yandex.net;
 envelope-from=shawn@git.icu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=git.icu
X-Greylist: delayed 122 seconds by postgrey-1.36 at bilbo;
 Mon, 21 Dec 2020 18:34:18 AEDT
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net
 [5.45.198.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Czrnk2qkRzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2020 18:34:17 +1100 (AEDT)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
 by forward100j.mail.yandex.net (Yandex) with ESMTP id 1363850E2B05
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2020 10:28:48 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
 by forward100q.mail.yandex.net (Yandex) with ESMTP id 0FF11708000E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2020 10:28:48 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id jLjFvibLQj-SlJqPobL; 
 Mon, 21 Dec 2020 10:28:47 +0300
Authentication-Results: mxback3q.mail.yandex.net; dkim=pass
Received: by vla1-f9f1a056fcaa.qloud-c.yandex.net with HTTP;
 Mon, 21 Dec 2020 10:28:47 +0300
From: Shawn Landden <shawn@git.icu>
To: linuxppc-dev@lists.ozlabs.org
Subject: unsubscribe
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 21 Dec 2020 02:28:47 -0500
Message-Id: <6271201608535695@mail.yandex.com>
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

