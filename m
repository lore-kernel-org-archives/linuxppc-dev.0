Return-Path: <ryan@elevated-networks.com>
In-Reply-To: <20041024234000.EADA1C1430@atlas.denx.de>
References: <20041024234000.EADA1C1430@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B59F0761-2618-11D9-BA35-0050E4B0DC64@elevated-networks.com>
From: Ryan Wilkins <ryan@elevated-networks.com>
Date: Sun, 24 Oct 2004 19:59:15 -0400
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: MPC850 and GDB help 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 24, 2004, at 7:39 PM, Wolfgang Denk wrote:

> This is the wrong approach. First understand the problem, and fix it.
> You will need exavctly this understanding to be able to port U-Boot.
>
> You MUST go step by step. You cannot leapfrog problems.

Understood.  I need to understand a lot of things first.

> Check the documentation for your _board_. If you have  it,  that  is.
> [And  if  you  don't,  then either give up now or plan for a _lot_ of
> frustrating experience.]
>
The board is an ADSL modem that was designed specifically by the ISP.  
The firmware would not allow operation with another ISP and this ISP 
has since gone out of business.  Other than the custom firmware not 
allowing ISP changes, it worked the same as anyone else.  There is no 
documentation publicly available on this board.  This board is based on 
a MPC850 processor, hence the reason I'm trying to get into it.  I 
expect a lot of frustrating experiences trying to get this thing to 
work, but I don't see why I can't work my way through it.  All of the 
solder connections from the 850 to the logic board appear on the 
opposite side of the board directly under the 850.  With any luck, I 
should be able to trace out certain lines to verify what is connected 
to what.  As for the other components present on the board, they're all 
easily identifiable.  I think with a little bit of work, I can load 
u-boot and Linux on this thing.

Thanks for the comments,
Ryan Wilkins
