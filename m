Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id A98672BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 03:26:51 +1100 (EST)
Date: Thu, 13 Jan 2005 09:26:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Goforth, Edward" <Ed.Goforth@gd-ais.com>
Message-ID: <20050113092638.B25004@home.com>
References: <9A48EF7239039B48834A3F6B644B0C71EF8750@vaff06-mail01.ad.gd-ais.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A48EF7239039B48834A3F6B644B0C71EF8750@vaff06-mail01.ad.gd-ais.com>;
	from Ed.Goforth@gd-ais.com on Thu, Jan 13, 2005 at 10:14:20AM -0500
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

On Thu, Jan 13, 2005 at 10:14:20AM -0500, Goforth, Edward wrote:
> Thanks to everyone who responded.  Now that a RTC is not a requirement,
> can anyone offer advice on what I will need to do to get the kernel
> (2.4.18) to play nice?

Are you using the linuxppc-2.4 tree? If you want up to date 2.4 4xx
support you should be using that tree as a starting point. Support
is better yet in 2.6 where most developers are spending their time.

-Matt
