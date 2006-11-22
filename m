Return-Path: <david-b@pacbell.net>
Received: from smtp107.sbc.mail.mud.yahoo.com (smtp107.sbc.mail.mud.yahoo.com
	[68.142.198.206]) by ozlabs.org (Postfix) with SMTP id 0124E67C67
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 07:02:13 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: NTP time sync
Date: Wed, 22 Nov 2006 11:55:23 -0800
References: <20061122203633.611acaa8@inspiron>
In-Reply-To: <20061122203633.611acaa8@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611221155.26686.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, Andi Kleen <ak@muc.de>, lethal@linux-sh.org,
	paulus@samba.org, rmk@arm.linux.org.uk, davem@davemloft.net,
	kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 November 2006 11:36 am, Alessandro Zummo wrote:
> 
>  wrto the in-kernel NTP synchronization,
>  as discussed before [1], my opinion
>  is that it should be done in userland.
> 
>  Keeping it in kernel implies subtle code
>  in each of the supported architectures.
> 
>  So, if the arch maintainers agree, 
>  I would suggest to schedule it for removal.
> 
> [1] http://lkml.org/lkml/2006/3/28/358

Suggested time of removal: one year after two relevant software
package releases get updated:

  - NTPD, to call hwclock specifying the relevant RTC;
  - util-linux, updating hwclock to know about /dev/rtcN;
  - busybox, with its own hwclock implementation.

The util-linux hwclock update is already in the queue, I'm told.

- Dave
