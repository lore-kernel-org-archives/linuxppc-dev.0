Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYqZ00Bz9zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 22:18:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Daney <david.daney@cavium.com>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Chris Metcalf <cmetcalf@mellanox.com>,
 Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>,
 Rabin Vincent <rabin@rab.in>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@kernel.org>,
 Zhigang Lu <zlu@ezchip.com>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <87varsj6qc.fsf@concordia.ellerman.id.au>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <87varsj6qc.fsf@concordia.ellerman.id.au>
Date: Thu, 02 Mar 2017 22:18:30 +1100
Message-ID: <8737ewexkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> David Daney <david.daney@cavium.com> writes:
>> Strict alignment became necessary with commit 3821fd35b58d
>> ("jump_label: Reduce the size of struct static_key"), currently in
>> linux-next, which uses the two least significant bits of pointers to
>> __jump_table elements.
>
> It would obviously be nice if this could go in before the commit that
> exposes the breakage, but I guess that's problematic because Steve
> doesn't want to rebase the tracing tree.
>
> Steve I think you've already sent your pull request for this cycle? So I
> guess if this can go in your first batch of fixes?

Ugh. Was looking at the wrong tree - Linus has already merged the commit
in question, so the above is all moot.

cheers
