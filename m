Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXGln5l6nzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 09:36:37 +1100 (AEDT)
Date: Mon, 27 Feb 2017 17:36:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Jason
 Baron <jbaron@akamai.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Anton
 Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>, Russell King
 <linux@armlinux.org.uk>, Chris Metcalf <cmetcalf@mellanox.com>, Zhigang Lu
 <zlu@ezchip.com>
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Message-ID: <20170227173630.57fff459@gandalf.local.home>
In-Reply-To: <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Feb 2017 14:21:21 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> See attached for mips.  It seems to do the right thing.
> 
> I leave it as an exercise to the reader to fix the other architectures.
> 
> Consult your own  binutils experts to verify that what I say is true.

It may still just be safer to do the pointers instead. That way we
don't need to worry about some strange arch or off by one binutils
messing it up.

-- Steve
