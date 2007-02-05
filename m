Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5A274DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 03:16:16 +1100 (EST)
Message-ID: <45C75844.9000309@freescale.com>
Date: Mon, 05 Feb 2007 10:16:04 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: MPC8360 : PCI resource allocate error
References: <000c01c746db$6451e7e0$6405a8c0@absolut>	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>	<001101c746e3$5b8dab00$6405a8c0@absolut>	<A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
	<000601c74754$b9a1eb90$6405a8c0@absolut>
In-Reply-To: <000601c74754$b9a1eb90$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Russell McGuire wrote:

> Yes, actually of the 6 cards I have, all are seen except the USB card. 
> And the USB card is seen in all other slots. So it appears to be a SLOT
> issue, but not a card issue.  Somehow this card is unique and uncovering an
> error that I don't know about yet. Perhaps I have a single address line
> sizzled or something. This is the same slot that has the IO resource
> allocation problems; I don't think I need to debug that in Linux. 

It could also be a card ordering problem.  In the x86 world, I've seen issues 
where a particular card had to be located at a higher/lower PCI slot than some 
other card.

However, my guess is that the USB card depends on a particular pin that none of 
your cards uses, and that pin is busted in slot 3.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
