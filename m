Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445951A0F01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 23:18:40 +1000 (AEST)
Date: Fri, 19 Jun 2015 15:18:36 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
Message-ID: <20150619131836.GD3805@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <20150618125539.5ff2c64f@gandalf.local.home> <20150619120044.GA3805@lst.de>
 <20150619084044.0b49e7ad@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150619084044.0b49e7ad@grimm.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 19, 2015 at 08:40:44AM -0400, Steven Rostedt wrote:
> On Fri, 19 Jun 2015 14:00:44 +0200
> Torsten Duwe <duwe@lst.de> wrote:
> 
> 
> > | kernel/bounds.c:1:0: error: -mcall-aixdesc incompatible with -mabi=elfv2
> > 
> > Are you building ppc64, little endian, ELF ABIv2 ?
> 
> It's big endian.

And ABIv1, consequently, and then you probably don't have .localentry.
The code inherently assumes ABIv2, v1 does not work.

I'll add a dependency on v2 then, if possible.

	Torsten
