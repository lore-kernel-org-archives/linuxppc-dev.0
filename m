Return-Path: <SRS0=Vz7S=2J=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXkNw00XxzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 03:21:51 +1100 (AEDT)
Date: Tue, 28 Feb 2017 11:21:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: Jason Baron <jbaron@akamai.com>, David Daney
 <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org, Chris Metcalf
 <cmetcalf@mellanox.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle
 <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>, Rabin Vincent
 <rabin@rab.in>, Paul Mackerras <paulus@samba.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Zhigang Lu
 <zlu@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Message-ID: <20170228112144.65455de5@gandalf.local.home>
In-Reply-To: <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
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

On Tue, 28 Feb 2017 10:25:46 +0530
Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:

> File: ./net/ipv4/xfrm4_input.o
>   [12] __jump_table      PROGBITS        0000000000000000 000639 000018 18 WAM  0   0  1
> File: ./net/ipv4/udplite.o
> File: ./net/ipv4/xfrm4_output.o
>   [ 9] __jump_table      PROGBITS        0000000000000000 000481 000018 18 WAM  0   0  1

Looks like there's some issues right there.

-- Steve
