Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 12:42:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071120014218.GD3126@localhost.localdomain>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<621f1d7bb87a49559d22162314b98398@kernel.crashing.org>
	<4741C0C4.4070502@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4741C0C4.4070502@genesi-usa.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 04:58:44PM +0000, Matt Sealey wrote:
> Segher Boessenkool wrote:
> >> And I forgot the rant you guys usually get - for god's sake, why isn't
> >> anyone using the "model" property?
> > 
> > Probably because it isn't useful all that often.
> > 
> >> sound@0 {
> >>     \\ this is our magic audio fabric
> >>     device_type = "digispeaker,flinger";
> > 
> > This is wrong in so many ways; see David's mail for a start.
> 
> Why? I'm sorry but I am living in the real world where we have real
> firmwares and real dynamic device trees here. You can't just say
> "this is wrong because it has a device_type".

It's not wrong because it has a device_type, it's wrong because the
device_type value is some random made-up thing that doesn't have an OF
binding behind it.  Nor do you suggest an OF binding.  Nor should
driver selection be based off device_type.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
