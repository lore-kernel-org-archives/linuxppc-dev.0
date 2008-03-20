Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 Mar 2008 11:21:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: simple MPC5200B system
Message-ID: <20080320002149.GD19616@localhost.localdomain>
References: <47DF821B.6090600@matrix-vision.de>
	<20080320001445.C03DD24A8B@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080320001445.C03DD24A8B@gemini.denx.de>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 01:14:45AM +0100, Wolfgang Denk wrote:
> In message <47DF821B.6090600@matrix-vision.de> you wrote:
> >
> > I've pulled the latest git and built a mpc5200_simple system with a 
> > minimal dts.
> > There's not a single char put on the console ....
> 
> You did build your device tree with "-b 0", didn't you?

Ugh.. I really need to fix dtc to pick the default boot cpu value more
sensibly, don't I.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
