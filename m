Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E41511A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 20:33:19 +1100 (AEDT)
Date: Thu, 21 Jan 2016 10:33:03 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Petr Mladek <pmladek@suse.com>, Torsten Duwe <duwe@lst.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
In-Reply-To: <1453269803.14751.10.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1601211032430.21446@cbobk.fhfr.pm>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Jan 2016, Michael Ellerman wrote:

> For me the series doesn't even boot, even with livepatching disabled.

Could you please post config and dmesg from that non-booting kernel?

Thanks,

-- 
Jiri Kosina
SUSE Labs
