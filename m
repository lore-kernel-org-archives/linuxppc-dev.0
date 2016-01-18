Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E22B1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 10:29:03 +1100 (AEDT)
Message-ID: <1453159742.24878.0.camel@ellerman.id.au>
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>, Torsten Duwe <duwe@lst.de>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Tue, 19 Jan 2016 10:29:02 +1100
In-Reply-To: <alpine.LNX.2.00.1601182321230.21446@cbobk.fhfr.pm>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172902.82C6C69260@newverein.lst.de>
 <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
 <20151201172914.GB5509@lst.de> <1449008285.12022.0.camel@ellerman.id.au>
 <20160105155857.GA2699@lst.de>
 <alpine.LNX.2.00.1601182321230.21446@cbobk.fhfr.pm>
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

On Mon, 2016-01-18 at 23:22 +0100, Jiri Kosina wrote:
> On Tue, 5 Jan 2016, Torsten Duwe wrote:
> 
> > > I (still) haven't had a chance to have a good look at it, but I won't this week
> > > anyway. So post v5 and hopefully I can review that and it will be perfect :)
> > 
> > The perfect v5 is there now, for 4 weeks minus the holiday season, and 
> > no further problems arose. Independently verified by Petr Mladek -- 
> > don't forget his high-level fix.
> 
> Hi everybody,
> 
> so what are the current plans with this one, please? Is this going through 
> ppc tree, ftrace tree, or does it have issues that need to be worked on 
> before merging?

Anton and I need to review it and then it will be merged via the powerpc tree.
We just haven't had the spare cycles to do it.

cheers
