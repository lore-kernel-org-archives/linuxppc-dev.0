Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 751B467CCD
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 07:23:57 +1100 (EST)
Date: Wed, 22 Nov 2006 21:23:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Subject: Re: NTP time sync
Message-ID: <20061122212355.046de470@inspiron>
In-Reply-To: <200611221155.26686.david-b@pacbell.net>
References: <20061122203633.611acaa8@inspiron>
	<200611221155.26686.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, hackers@lists.ntp.isc.org, Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, Kim,
	davem@davemloft.net, kkojima@rr.iij4u.or.jp, mills@udel.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Nov 2006 11:55:23 -0800
David Brownell <david-b@pacbell.net> wrote:

> > 
> >  So, if the arch maintainers agree, 
> >  I would suggest to schedule it for removal.
> > 
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> Suggested time of removal: one year after two relevant software
> package releases get updated:
> 
>   - NTPD, to call hwclock specifying the relevant RTC;

 This might introduce delays. ntpd might open the device
 and update the time itself.

>   - util-linux, updating hwclock to know about /dev/rtcN;
>   - busybox, with its own hwclock implementation.
> 
> The util-linux hwclock update is already in the queue, I'm told.

 I suspect nobody would change NTPD if we don't
 schedule that feature for removal :)


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
