Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id B2B982BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 10:48:20 +1100 (EST)
Date: Wed, 12 Jan 2005 16:48:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Goforth, Edward" <Ed.Goforth@gd-ais.com>
Message-ID: <20050112164809.F22626@home.com>
References: <9A48EF7239039B48834A3F6B644B0C71EF8679@vaff06-mail01.ad.gd-ais.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A48EF7239039B48834A3F6B644B0C71EF8679@vaff06-mail01.ad.gd-ais.com>;
	from Ed.Goforth@gd-ais.com on Wed, Jan 12, 2005 at 06:25:45PM -0500
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: board with no RTC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 06:25:45PM -0500, Goforth, Edward wrote:
> We have a 440gx based custom board.  I have learned that it does not
> have a RTC. Has anyone had any success with a board without a RTC, or is
> it even possible?  How much of a problem will this cause?  
> 
> Should we get the board respun with a RTC?  We would prefer using a 2.4
> kernel, but would certainly go to a 2.6 kernel if that made things
> easier.
> 
> Thanks in advance for any advice.

No problems. Just set your time from another source. Many PPC boards
do this that don't need local time retention across power cycles.
I've got a 440gx board sitting here running happily this way.

-Matt
