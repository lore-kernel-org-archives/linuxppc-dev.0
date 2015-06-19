Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.227])
 by lists.ozlabs.org (Postfix) with ESMTP id 601311A0F3A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:47:10 +1000 (AEST)
Date: Fri, 19 Jun 2015 08:40:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
Message-ID: <20150619084044.0b49e7ad@grimm.local.home>
In-Reply-To: <20150619120044.GA3805@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <20150618125539.5ff2c64f@gandalf.local.home>
 <20150619120044.GA3805@lst.de>
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

On Fri, 19 Jun 2015 14:00:44 +0200
Torsten Duwe <duwe@lst.de> wrote:


> | kernel/bounds.c:1:0: error: -mcall-aixdesc incompatible with -mabi=elfv2
> 
> Are you building ppc64, little endian, ELF ABIv2 ?

It's big endian.

> Is your cross compiler working properly?

Well, just before applying your patches, I built and booted 4.1-rc8 on
that box. Then I applied the patches and got the error on build.

I just reverted your patches, and it builds again.

> 
> I'm compiling natively on that platform (faster for me than an x86 ;-)

x86 is bit faster for me to compile.

> | GNU assembler (GNU Binutils; SUSE Linux Enterprise 12) 2.24.0.20140403-7
> | gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]

I'm using the cross tool chains from kernel.org

https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

 powerpc64-linux-gcc (GCC) 4.6.3

> 
> 4.1.0-rc8 config attached.

Um, what do you want me to do with your config? If your patches don't
build on my box when vanilla does, it's a regression. In other words,
you broke my machine.

-- Steve
