Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4581A0F05
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2015 00:04:07 +1000 (AEST)
Date: Fri, 19 Jun 2015 16:04:03 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
Message-ID: <20150619140403.GA8681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes since v1: adjusted dashes, whitespace, make checkpatch happy.
No functional changes.

Do NOT select FTRACE_WITH_REGS on ELF ABI v1 !
For C source, there's
#if defined(_CALL_ELF) && _CALL_ELF == 2
Maybe there's something for Kconfig, too.

	Torsten
