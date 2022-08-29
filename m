Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D68ECAAD4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Aug 2022 23:29:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MGmr46pTnz3cD8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Aug 2022 09:29:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ut5VdAQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ut5VdAQS;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MGmqN4HMDz3bYd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2022 09:29:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OaZc2la47vx8E0FS0qsEMIEXDCE3CBk13gYUqXeqdYY=; b=ut5VdAQSCW20WwiX52cz5GLV5l
	SagE5RRhTnCV0D/O5DxwlcDcnxMWTZv3uZMH0/mnlOHfc+mj1eLiIbpuspuL9w953JqEpGUudalQ0
	MA8YHCzoydg94IFvq4Y2bDheKbZhQYlNzpfbgtSslHmINXVPXyhjGuZYJuETFyUksDQ9zGC28wsue
	u7BSHeWYz1lhb9VK58gU9ZPyAj7faA1w/bhfb5IcR+vhlQHsJ9qtwn3/duz//nWLvTW/iT/XlhDqk
	iz+/buwKg2+DCnEF7onNWO71fH+GKTevKBv13ya83gqS2cbLFq0RR2uTJlTELIgdqcu0w7y8vFwV+
	0BNqBKvQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSoBt-003V9R-LQ; Mon, 29 Aug 2022 23:29:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: spufs: correct a duplicate word typo
Date: Mon, 29 Aug 2022 16:29:08 -0700
Message-Id: <20220829232908.32437-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix a typo of "or" which should be "of".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/spufs/spufs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/filesystems/spufs/spufs.rst
+++ b/Documentation/filesystems/spufs/spufs.rst
@@ -227,7 +227,7 @@ Files
               from the data buffer, updating the value of the specified signal
               notification register.  The signal  notification  register  will
               either be replaced with the input data or will be updated to the
-              bitwise OR or the old value and the input data, depending on the
+              bitwise OR of the old value and the input data, depending on the
               contents  of  the  signal1_type,  or  signal2_type respectively,
               file.
 
