Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88AF947534
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 20:32:36 +1100 (EST)
Date: Mon, 12 Jan 2009 10:32:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090112093214.GA6798@elte.hu>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop> <20090112090552.GD26750@elte.hu>
	<20090112202427.3b918490.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090112202427.3b918490.sfr@canb.auug.org.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > It slipped through because it didnt get caught in build tests because 
> > cpufreq isnt enabled in the powerpc defconfig.
> 
> Which is one of the reasons we have linux-next: "integration testing".

Build bugs slipped through that net too in the past.

And we dont really want developers and maintainers to rely on an external 
middle man facility to be able to submit patches. So the best method is to 
make the defconfigs good enough to catch everyday build bugs. Random 
testing and linux-next can then catch the weird special cases as well.

	Ingo
