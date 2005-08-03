Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 24ADD67E05
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 04:40:11 +1000 (EST)
Date: Wed, 3 Aug 2005 11:39:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050803183932.GA13789@mag.az.mvista.com>
References: <9b7ca6570508022240715ae9cb@mail.gmail.com>
	<61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
	<9b7ca65705080223401a9ce913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca65705080223401a9ce913@mail.gmail.com>
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

On Wed, Aug 03, 2005 at 03:40:18PM +0900, Daniel Ann wrote:
> Absolutely not. Very much like sandpoint except, we dont use SIO at all.
> FYI, most of sandpoint code from the kernel is function the board very
> well at the moment. Only big issue lies with REBOOT at this stage:(

Daniel,

IIRC, the sandpoint uses the PC style port 92 mechanism to reset the board.
You need to look at your hardware docs to see how your board can be reset.
Don't expect the sandpoint reset code to work for you.

Mark
