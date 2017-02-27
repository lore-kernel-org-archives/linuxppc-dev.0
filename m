Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX1td6qW7zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 23:56:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc: kretprobes: override default function
 entry offset
In-Reply-To: <20170224195722.GM3595@kernel.org>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170224195722.GM3595@kernel.org>
Date: Mon, 27 Feb 2017 23:56:40 +1100
Message-ID: <87bmtnrdvb.fsf@concordia.ellerman.id.au>
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

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Wed, Feb 22, 2017 at 07:23:38PM +0530, Naveen N. Rao escreveu:
>> With ABIv2, we offset 8 bytes into a function to get at the local entry
>> point.
>
> So, I think I can carry the first one via Ingo, etc, what about this
> one?
>
> Is it ok for me to process it?

Yes please.

> Seems simple enough, has been thru a lot of discussion, but would be
> better if it was Reviewed-by the PPC maintainers or else just processed
> by them.
>
> Please advise,

I think it's best if you take it with patch 1. I realise they could go
separately, but they make more sense together I think.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
