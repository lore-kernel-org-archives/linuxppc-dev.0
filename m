Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200704130210.48508.arnd@arndb.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121926.03723.arnd@arndb.de>
	<e5b10849669a764f002d1926838edc76@kernel.crashing.org>
	<200704130210.48508.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00df01c80b8b5153a04a7cbe0bc727f2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Fri, 13 Apr 2007 20:43:02 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> My understanding at this point is that we can always fall back
> to -mcpu=powerpc or -mcpu=powerpc64,

Yes.  With perhaps and added -mno-string or similar if
some supported CPU really needs it.


>  and also

[SNIP]

> So if we select e.g. power6 and cell, it needs to fall back to power4,
> which is the common subset. Selecting both 403 and 405 would result
> in falling back to -mcpu=powerpc, because they don't have any larger
> subset.

This is way complicated.  Also, it is not unique to the
kernel; you'd be better off adding this logic to the
compiler itself.  OTOH, it's such a niche market, maybe
the distros that want it (if any do) should do this in
their RPM build scripts or similar.


Segher
