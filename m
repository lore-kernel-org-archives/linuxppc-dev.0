Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMmYQ0pg9zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:28:09 +1100 (AEDT)
Date: Mon, 13 Feb 2017 19:49:16 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc: Blacklist GCC 5.4 6.1 and 6.2
Message-ID: <20170214014916.GR21840@gate.crashing.org>
References: <20170213033536.8908-1-cyrilbur@gmail.com>
 <20170213154437.GP21840@gate.crashing.org>
 <1487031943.9122.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487031943.9122.1.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2017 at 11:25:43AM +1100, Cyril Bur wrote:
> > > At the time of writing GCC 5.4 is the most recent and is affected. GCC
> > > 6.3 contains the backported fix, has been tested and appears safe to
> > > use.
> > 
> > 6.3 is (of course) the newer release; 5.4 is a maintenance release of
> > a compiler that is a year older.
> 
> Yes. I think the point I was trying to make is that since they
> backported the fix to 5.x and 6.x then I expect that 5.5 will have the
> fix but since it doesn't exist yet, I can't be sure. I'll add something
> to that effect.

The patch has been backported to the GCC 5 branch; it will be part of
any future GCC 5 release (5.5 and later, if any later will happen; 5.5
will).

Don't be so unsure about these things, we aren't *that* incompetent ;-)

> > Please mention the GCC PR # somewhere in the code, too?
> 
> Sure.

Thanks!


Segher
