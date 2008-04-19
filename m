Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 129C7DE42E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 16:11:28 +1000 (EST)
Date: Fri, 18 Apr 2008 23:11:28 -0700 (PDT)
Message-Id: <20080418.231128.97404791.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
From: David Miller <davem@davemloft.net>
In-Reply-To: <18441.33181.511355.338428@cargo.ozlabs.ibm.com>
References: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
	<20080418.210933.01471700.davem@davemloft.net>
	<18441.33181.511355.338428@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, scottwood@freescale.com, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 19 Apr 2008 15:22:37 +1000

> David Miller writes:
> > From: Paul Mackerras <paulus@samba.org>
> > Date: Sat, 19 Apr 2008 14:04:32 +1000
> > 
> > It's OK if this breaks the sparc64 allmodconfig build, I'll take
> > care of this once it's merged in.
> 
> It breaks the sparc32 allmodconfig build, which seems to be a
> concern.  How do you suggest we fix that?

I'll fix both sparc64 and sparc32 builds when I merge my sparc
tree in.
