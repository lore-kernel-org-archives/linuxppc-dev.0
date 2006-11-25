Return-Path: <david-b@pacbell.net>
Received: from smtp104.sbc.mail.mud.yahoo.com (smtp104.sbc.mail.mud.yahoo.com
	[68.142.198.203]) by ozlabs.org (Postfix) with SMTP id C270367BB4
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Nov 2006 10:22:41 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: NTP time sync
Date: Sat, 25 Nov 2006 15:22:18 -0800
References: <20061122203633.611acaa8@inspiron> <20061123105400.GA75714@muc.de>
	<1164279605.5653.51.camel@localhost.localdomain>
In-Reply-To: <1164279605.5653.51.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200611251522.19900.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: akpm@osdl.org, Alessandro Zummo <alessandro.zummo@towertech.it>,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, Andi Kleen <ak@muc.de>, paulus@samba.org,
	rmk@arm.linux.org.uk, davem@davemloft.net, kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 November 2006 3:00 am, Benjamin Herrenschmidt wrote:
> 
> Couldn't we have a transition period by making the kernel not rely on
> interrupts ? if the NTP irq code just triggers a work queue, then all of
> a sudden, all of the RTC drivers can be used and the latency is small.
> That might well be a good enough solution and is very simple.

Good point.  Of course, one issue is that the NTP sync code all
seems to be platform-specific right now ... just like the code
to set the system time from an RTC at boot (except for the new
RTC framework stuff) and after resume.

- Dave
