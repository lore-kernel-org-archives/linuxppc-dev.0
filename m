Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E64531A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:59:46 +1100 (AEDT)
Date: Thu, 26 Nov 2015 13:59:43 +0100
From: Torsten Duwe <duwe@lst.de>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
Message-ID: <20151126125943.GB6484@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172902.82C6C69260@newverein.lst.de>
 <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2015 at 01:04:19PM +0300, Denis Kirjanov wrote:
> On 11/25/15, Torsten Duwe <duwe@lst.de> wrote:
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> Linux style for comments is the C89. Please update entry_64.S

I might as well switch to asm-style comments. Anyway, thanks 
for the reminder.

	Torsten
