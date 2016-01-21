Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 687CE1A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 22:34:54 +1100 (AEDT)
Date: Thu, 21 Jan 2016 12:34:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160121113443.GD3305@pathway.suse.cz>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
 <20160120094830.GA3178@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120094830.GA3178@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2016-01-20 10:48:30, Petr Mladek wrote:
> I did the testing on PPC64LE with a kernel based on 4.4.0-rc8
> using the attached config. I used the following stuff:

Ah, I forgot to attach it. Also it is rahter big. Please,
find it at http://pastebin.com/tzJ3mdUd

Best Regards,
Petr
