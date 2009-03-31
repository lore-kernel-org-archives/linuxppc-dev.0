Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id E7F0DDDE28
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:29:52 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so2540388rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 06:29:51 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 31 Mar 2009 09:29:44 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Add hvc_console to MAINTAINERS
Message-ID: <20090331132944.GB2332@yoda.jdub.homelinux.org>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090330141852.59baaeda.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, roel.kluin@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a MAINTAINERS entry for the hypervisor virtual console support
used on IBM POWER servers.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---

diff --git a/MAINTAINERS b/MAINTAINERS
index c5f4e9d..387ad45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2176,6 +2176,11 @@ W:       http://www.ia64-linux.org/
 T:     git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
 S:     Maintained
 
+IBM HYPERVISOR VIRTUAL CONSOLE
+P:     Several
+L:     linuxppc-dev@ozlabs.org
+S:     Maintained
+
 IBM MCA SCSI SUBSYSTEM DRIVER
 P:     Michael Lang
 M:     langa2@kph.uni-mainz.de
