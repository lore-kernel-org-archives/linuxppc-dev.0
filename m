Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFBAF1A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 02:17:32 +1000 (AEST)
Date: Thu, 18 Jun 2015 18:17:27 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
Message-ID: <20150618161727.GA6546@lst.de>
References: <20150611095338.GA4492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150611095338.GA4492@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did I miss anything else? I have the notrace optimisations and
kernel live patching in the queue, which depends on this, so I'd
really appreciate a comment whether it is acceptable in this form
or not. Thanks in advance!

	Torsten
