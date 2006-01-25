Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by ozlabs.org (Postfix) with SMTP id 7C87468A00
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 02:52:15 +1100 (EST)
In-Reply-To: <20060123042413.806.qmail@web32201.mail.mud.yahoo.com>
References: <20060123042413.806.qmail@web32201.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8c05211d33576b79dee80725822322b@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: 2.4.x vs 2.6.x performance
Date: Wed, 25 Jan 2006 07:45:38 -0800
To: Frank <frannk_m1@yahoo.com>
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


On Jan 22, 2006, at 8:24 PM, Frank wrote:

> I remember reading a while back that the 2.6 kernel is
> considerably slower

I wouldn't say "considerably" slower, but there are some
performance differences.  It's most evident on the
smaller, slower processors, like the 8xx, but we have
taken steps to alleviate that.  The problem is 2.6 is just
bigger with more stuff in it.  You want the new features,
you have to pay for that somewhere.  I think it would
help if the kernel was a little more configurable for
embedded systems.  It seems there is just too much
stuff in a basic kernel that I wish could be stripped out.

> I'm thinking about moving to 2.6 since a lot of open source
> projects have stopped suporting the 2.4 kernel.

You know, this is a "community effort", not "when are you
going to fix it for me" :-)  Use 2.6, measure it using your
application, and submit updates that improve it. Some of
us have already done quite a bit, so do your part, too.

Thanks.

	-- Dan
