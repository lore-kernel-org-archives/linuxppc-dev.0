From: jtm@smoothsmoothie.com
Date: Wed, 12 Dec 2001 11:14:57 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Dixon <andrew.dixon@seranoa.com>,
	ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: r3 and bd_t
Message-ID: <20011212171457.GA20492@shamus.smoothsmoothie.com>
References: <3C164F4B.E9A4FCA2@seranoa.com> <20011211183430.GQ22045@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011211183430.GQ22045@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 11, 2001 at 11:34:30AM -0700, Tom Rini wrote:
>

> arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
> iirc, which will pass it along to platform_init(), which copies it for
> safe keeping.

I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
