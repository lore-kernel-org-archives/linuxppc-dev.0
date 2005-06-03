Return-Path: <mmporter@cox.net>
Date: Thu, 2 Jun 2005 17:18:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050602171822.G24818@cox.net>
References: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>;
	from kumar.gala@freescale.com on Thu, Jun 02, 2005 at 06:19:11PM
	-0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Getting ownership for various boards/platforms configs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2005 at 06:19:11PM -0500, Kumar Gala wrote:
> One issue that comes up from time to time is knowing who to contact 
> about some of the various boards that are supported for PPC.  I've 
> suggested in the past that we create a MAINTAINERS file in 
> arch/ppc/platforms.  I've started with a list of all the _defconfigs 
> that we have and would like to see if we can get contacts for the 
> boards.  All this list is meant to be is a contact point.
> 
> The following is the list, I'll keep a live copy at 
> http://gate.crashing.org/~galak/platform-owners.  Once it gets flushed 
> out I'll turn it into file that looks more like the toplevel 
> MAINTAINERS file.  If we dont have any owners for a board we can 
> discuss if support for it should be removed.  Please email me if you 
> feel you are the owner of any board/config.
> 
> thanks
> 
> - kumar
> 
> ash
> beech

These are't in 2.6, remove the defconfig

> bubinga

me/ebs

> cedar

This isn't in 2.6, remove the defconfig

> ebony

me/ebs

> k2

I did the original port, now unmaintained/obsolete..die die die.

> lopec

trini is probably the maintainer here...he likes this board.

> luan

me

> menf1			Dead (Matt Porter)

Remove it, yes.

> oak

I think it's time to remove it...unmaintained.

> ocotea

me/ebs

> rainier

Not in 2.6...remove defconfig

> redwood5
> redwood6

um...dfarnsworth, want them formally?

> redwood

Not in 2.6...remove defconfig

> stx_gp3

me

> sycamore

me

> walnut

me
