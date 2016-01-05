Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2CB01A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 02:59:03 +1100 (AEDT)
Date: Tue, 5 Jan 2016 16:58:58 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ppc64le FTRACE_WITH_REGS implementation
Message-ID: <20160105155857.GA2699@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172902.82C6C69260@newverein.lst.de>
 <CAOJe8K34bA=LytXouWhjfkgqsR2cTLimMJc-S88RC56dj3x-=Q@mail.gmail.com>
 <20151201172914.GB5509@lst.de> <1449008285.12022.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449008285.12022.0.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 02, 2015 at 09:18:05AM +1100, Michael Ellerman wrote:
> 
> I (still) haven't had a chance to have a good look at it, but I won't this week
> anyway. So post v5 and hopefully I can review that and it will be perfect :)

The perfect v5 is there now, for 4 weeks minus the holiday season, and no further
problems arose. Independently verified by Petr Mladek -- don't forget his high-level fix.

	Torsten
