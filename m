Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5327D1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 09:22:39 +1100 (AEDT)
Date: Mon, 18 Jan 2016 23:22:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>
cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
In-Reply-To: <20160105155857.GA2699@lst.de>
Message-ID: <alpine.LNX.2.00.1601182321230.21446@cbobk.fhfr.pm>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172902.82C6C69260@newverein.lst.de>
 <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
 <20151201172914.GB5509@lst.de> <1449008285.12022.0.camel@ellerman.id.au>
 <20160105155857.GA2699@lst.de>
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

On Tue, 5 Jan 2016, Torsten Duwe wrote:

> > I (still) haven't had a chance to have a good look at it, but I won't this week
> > anyway. So post v5 and hopefully I can review that and it will be perfect :)
> 
> The perfect v5 is there now, for 4 weeks minus the holiday season, and 
> no further problems arose. Independently verified by Petr Mladek -- 
> don't forget his high-level fix.

Hi everybody,

so what are the current plans with this one, please? Is this going through 
ppc tree, ftrace tree, or does it have issues that need to be worked on 
before merging?

Thanks!

-- 
Jiri Kosina
SUSE Labs
