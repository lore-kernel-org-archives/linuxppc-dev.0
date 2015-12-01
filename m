Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CD221A0B63
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 04:29:18 +1100 (AEDT)
Date: Tue, 1 Dec 2015 18:29:14 +0100
From: Torsten Duwe <duwe@lst.de>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
Message-ID: <20151201172914.GB5509@lst.de>
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
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 8d56b16..3309dd8 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> Linux style for comments is the C89. Please update entry_64.S

Any other (planned) remarks or comments on the patch set?
If not I'll make a 5th, hopefully final version.

	Torsten
