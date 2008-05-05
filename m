Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 May 2008 11:16:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add Phytec pcm030 board support
Message-ID: <20080505011607.GA9349@yookeroo.seuss>
References: <20080425134805.GP6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080425134805.GP6692@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 03:48:05PM +0200, Sascha Hauer wrote:
> Add board support for the Phytec pcm030 mpc5200b based board. It
> does not need any platform specific fixups and as such is handled
> as a mpc5200 simple platform.

Those still whingeing about how horrible and hard and tedious the new
world of device trees is, take note.  We've certainly had some
teething problems as we all figure out how to use the device tree
properly.  But this is the payoff: support for a new board added with
one text file.  It's only going to get more common.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
