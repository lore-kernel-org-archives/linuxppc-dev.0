Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9467F1A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 09:18:05 +1100 (AEDT)
Message-ID: <1449008285.12022.0.camel@ellerman.id.au>
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Wed, 02 Dec 2015 09:18:05 +1100
In-Reply-To: <20151201172914.GB5509@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172902.82C6C69260@newverein.lst.de>
 <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
 <20151201172914.GB5509@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-01 at 18:29 +0100, Torsten Duwe wrote:
> On Thu, Nov 26, 2015 at 01:04:19PM +0300, Denis Kirjanov wrote:
> > > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > > index 8d56b16..3309dd8 100644
> > > --- a/arch/powerpc/kernel/entry_64.S
> > > +++ b/arch/powerpc/kernel/entry_64.S
> > Linux style for comments is the C89. Please update entry_64.S
> 
> Any other (planned) remarks or comments on the patch set?
> If not I'll make a 5th, hopefully final version.

I (still) haven't had a chance to have a good look at it, but I won't this week
anyway. So post v5 and hopefully I can review that and it will be perfect :)

cheers
