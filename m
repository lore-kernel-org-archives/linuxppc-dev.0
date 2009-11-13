Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83506.mail.sp1.yahoo.com (web83506.mail.sp1.yahoo.com
	[216.252.120.162]) by ozlabs.org (Postfix) with SMTP id 8F073B7B60
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:49:55 +1100 (EST)
Message-ID: <200007.626.qm@web83506.mail.sp1.yahoo.com>
Date: Fri, 13 Nov 2009 11:49:54 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bus Error on MPC8313
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4AFDB48D.9080203@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--- On Fri, 11/13/09, Scott Wood <scottwood@freescale.com> wrote:

> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: Bus Error on MPC8313
> To: "Ron Madrid" <ron_madrid@sbcglobal.net>
> Cc: linuxppc-dev@ozlabs.org
> Date: Friday, November 13, 2009, 11:33 AM
> Ron Madrid wrote:
> > I wrote a custom driver for an MPC8313 based
> board.  Everything seems to
> > have been working for a long time, but now one of my
> IOCTL functions seems
> > to be having a problem.  I'm getting a "Bus
> error" reported by my
> > application and also a kernel "Oops".  Here's
> what the kernel is reporting. 
> > Oops: Machine check, sig: 7 [#1]
> 
> Were there any messages before this?  Is there
> anything interesting in the arbiter registers?

No messages prior, only the normal kernel boot messages.  And when this
does happen in usually causes a lockup, so I haven't been able to check the
status of any arbiter registers.
 
> Is this custom driver using the localbus, and are there any
> NAND operations going on at the same time?

This driver does use the localbus.  It seems to happen (when it does) when
performing an access to our FPGA that is connected via UPM on the localbus. 
I do not know if there are any NAND operations going on at that same time. 
If there are, they are not being directly caused by any of my apps or
driver calls.

Ron
