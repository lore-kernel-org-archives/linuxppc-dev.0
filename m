Message-ID: <3DF8DA39.6040902@mvista.com>
Date: Thu, 12 Dec 2002 10:49:29 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Move 405LP RTC support from beech.c into ibm405lp.c
References: <20021212035459.GF4631@zax.zax>
In-Reply-To: <20021212035459.GF4631@zax.zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> The RTC support (written by Todd Poynor) for the Beech is actually in
> the 405LP chip itself, not just on the Beech board.  This patch moves
> the code into ibm405lp.c so that it's more easily accessible for
> non-Beech 405LP boards (there aren't any of these in the tree at the
> moment, but I expect to commit one within the week).
>
> If there are no objections, I will commit this to linuxppc_2_4_devel.

By all means... I realized shortly afterwards that I had "Beech on the
brain" and it was really a 405LP onchip device, so this was on my to-do
list anyhow.  (And credit to Bishop Brock for the original code.)


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
