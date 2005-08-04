Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 96D9767D7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 10:27:03 +1000 (EST)
Date: Wed, 3 Aug 2005 17:26:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050804002628.GA24797@mag.az.mvista.com>
References: <9b7ca6570508022240715ae9cb@mail.gmail.com>
	<61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
	<9b7ca65705080223401a9ce913@mail.gmail.com>
	<20050803183932.GA13789@mag.az.mvista.com>
	<9b7ca6570508031716786e73b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca6570508031716786e73b0@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245 reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2005 at 09:16:23AM +0900, Daniel Ann wrote:
> Mark,
> 
> Guess I'll have to walk the uncharted area again :P
> Thanks anyway tho. I'll start by looking at what that port 92
> mechanism is first, and see where in our hw designer have put that in.

Personally, I wouldn't waste my time on the port 92 stuff.  I really doubt the
hw engr did that unless your board is very PC-ish.  Does your board have any
"board" regs (e.g., some regs on a pld or something)?  If so, look through
those for a bit in a register that resets the system.

Mark
