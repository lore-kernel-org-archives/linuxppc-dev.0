Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83501.mail.sp1.yahoo.com (web83501.mail.sp1.yahoo.com
	[216.252.120.157]) by ozlabs.org (Postfix) with SMTP id 28144B7067
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:08:06 +1100 (EST)
Message-ID: <576259.11113.qm@web83501.mail.sp1.yahoo.com>
Date: Fri, 13 Nov 2009 12:08:05 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bus Error on MPC8313
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4AFDBA40.5070309@freescale.com>
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
> > And when this
> > does happen in usually causes a lockup, so I haven't
> > been able to check the
> > status of any arbiter registers.
> 
> The system is up long enough to print an oops; you could
> stick some output in the trap handler.

I've never done anything like that before so this could
take me a while to figure out and try.
 
> OK, check the localbus error registers as well.

OK

> Are there any filesystems mounted on NAND?  There are
> some issues with transactions timing out if there's
> contention with a long-running NAND operation.

Yes, a JFFS2.  If that is the case, is there any sort of
workaround?

Ron
