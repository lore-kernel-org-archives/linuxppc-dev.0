Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F8ECAAD2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Aug 2022 23:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MGmnj28F5z3c2N
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Aug 2022 09:27:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=if6CKD+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=if6CKD+I;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MGmn055Zsz2ypD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2022 09:27:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OaZc2la47vx8E0FS0qsEMIEXDCE3CBk13gYUqXeqdYY=; b=if6CKD+ID5vTHVmoiYHIbPUiGg
	Td2xXvwC5YNfttncSiVjnnYaQAvfwBXztLGZX7QvpskhGZ0PsBfRO35ie2hvIxUwYam39S6g5u9oJ
	DPMkqESJuYiNp1moMwijgpVnZlOt0banl9dj73WeBlObr7i1GdWuxFSMTQmuJIIHOZ8+5WPllnqkp
	Ws7LbkJ9wHHfxpduFcO1cOP2I3etr/TY3BMNJrJkAQpPOYItf3eVTY6DI/c4nGKgitUd9IUgN5+DU
	2NZy4OhSZn9ldpceT61U5Z5670BHkLLPd12f34yLNgiXSTA1+IEtjFMLFLVWB8SNrUgLuJ036r4aD
	0cD/LARA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSo9j-003V3k-DM; Mon, 29 Aug 2022 23:26:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Subject: [PATCH] >>>>>>>>>>>>>>>>>>>>>>>>> BLURB <<<<<<<<<<<<<<<<<<<
Date: Mon, 29 Aug 2022 16:26:53 -0700
Message-Id: <20220829232653.25060-1-rdunlap@infradead.org>
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
 
