Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id BC820DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:43:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2139706uge
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:43:46 -0800 (PST)
Date: Thu, 29 Nov 2007 22:44:23 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/5] PPC cleanup: do use for_each macro
Message-ID: <20071129194423.GA12123@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cleanup patch set. It does convert for(...)/while(...) cycles
into appropriate for_each_...() macros calls.

The patch set is splitted up in idea to hold changes localy
to a specified platform.

Any comments are welcome.

		Cyrill
