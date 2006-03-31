Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id D2B8A679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Apr 2006 05:58:36 +1100 (EST)
In-Reply-To: <200603312027.22359.roger.larsson@norran.net>
References: <20060331133619.GD7738@localhost.localdomain>
	<200603312027.22359.roger.larsson@norran.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84f8b653e927098568cab6da979caf04@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: mpc5200b and floating point
Date: Fri, 31 Mar 2006 13:58:36 -0500
To: Roger Larsson <roger.larsson@norran.net>
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


On Mar 31, 2006, at 1:27 PM, Roger Larsson wrote:

> Since a lot of PowerPC do not have floating point processor your tools
> might be setup to compile without it (compare with sse2 on x86).

Nearly all of the PowerPC do have floating point, only a few do not.
It's highly unlikely to find a PowerPC tool set that was custom
built to not enable floating point.  Don't forget that the compiler
flags are only a small part of the picture, you need matching
compiler run time support and application libraries as well.
Just using the compiler flags and not selecting the proper
libraries will not be a positive experience.


	-- Dan
