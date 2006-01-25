Return-Path: <solca@guug.org>
Received: from guug.org (guug.galileo.edu [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id 1D05368A75
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 06:08:14 +1100 (EST)
Date: Wed, 25 Jan 2006 12:41:38 -0600
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: 2.4.x vs 2.6.x performance
Message-ID: <20060125184138.GA12874@guug.org>
References: <20060123042413.806.qmail@web32201.mail.mud.yahoo.com>
	<c8c05211d33576b79dee80725822322b@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c8c05211d33576b79dee80725822322b@embeddedalley.com>
From: Otto Solares <solca@guug.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 07:45:38AM -0800, Dan Malek wrote:
> I wouldn't say "considerably" slower, but there are some
> performance differences.  It's most evident on the
> smaller, slower processors, like the 8xx, but we have
> taken steps to alleviate that.  The problem is 2.6 is just
> bigger with more stuff in it.  You want the new features,
> you have to pay for that somewhere.  I think it would
> help if the kernel was a little more configurable for
> embedded systems.  It seems there is just too much
> stuff in a basic kernel that I wish could be stripped out.

Many things can be stripped out with LinuxTiny patches:

http://www.selenic.com/linux-tiny/

-otto
