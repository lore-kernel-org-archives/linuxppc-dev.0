Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E23AB7C3E
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 00:55:10 +1100 (EST)
Received: by vs166246.vserver.de with esmtpa (Exim 4.69) id 1NTxst-0007u4-Sy
	for linuxppc-dev@ozlabs.org; Sun, 10 Jan 2010 13:31:11 +0000
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@ozlabs.org
Subject: Allocator MAX_ORDER exceeds SECTION_SIZE
Date: Sun, 10 Jan 2010 14:31:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001101431.10736.mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get the following compilation failure, if 64k pages is selected
on 2.6.32.3 on a PowerMAC config:

include/linux/mmzone.h:947:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE

Any idea?

-- 
Greetings, Michael.
