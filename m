Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E7811A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 11:33:34 +1100 (AEDT)
Message-ID: <1455064413.7576.3.camel@ellerman.id.au>
Subject: Re: [PATCH v7 07/10] ppc64 ftrace: disable profiling for some files
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Wed, 10 Feb 2016 11:33:33 +1100
In-Reply-To: <20160204162114.09AD4692E0@newverein.lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162114.09AD4692E0@newverein.lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-25 at 16:31 +0100, Torsten Duwe wrote:

> This patch complements the "notrace" attribute for selected functions.
> It adds -mprofile-kernel to the cc flags to be stripped from the command
> line for code-patching.o and feature-fixups.o, in addition to "-pg"

This could probably be folded into patch 5, and the combined patch would be
"remove -mprofile-kernel in all the same places we remove -pg and for the same
reasons".

I can't think of anywhere we would want to disable -pg but not disable
-mprofile-kernel? Or vice versa.

cheers
