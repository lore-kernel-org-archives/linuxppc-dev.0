Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id EB7B667CD1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 07:26:24 +1100 (EST)
Date: Wed, 22 Nov 2006 21:26:21 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: NTP time sync
Message-ID: <20061122212621.433593a2@inspiron>
In-Reply-To: <20061122195153.GC22601@flint.arm.linux.org.uk>
References: <20061122203633.611acaa8@inspiron>
	<20061122195153.GC22601@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org, paulus@samba.org,
	hackers@lists.ntp.isc.org, davem@davemloft.net,
	kkojima@rr.iij4u.or.jp, mills@udel.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Nov 2006 19:51:53 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> >  So, if the arch maintainers agree, 
> >  I would suggest to schedule it for removal.
> > 
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> Fine, provided there's also a shell tool that can enquire whether the
> kernel is sync'd or not.  (Currently the 11-minute update does not
> occur when the kernel is desynced from a time source - the RTC itself
> might be more accurate in this case.)
> 
> Throwing hwclock commands into crontab such that they do not take
> note of the kernel's sync status is probably a very bad move in that
> respect.

 I agree. I would like to coordinate this effort together with
 the ntp folks so that we can find a viable solution.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
