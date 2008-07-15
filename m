Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 Jul 2008 11:41:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Mikrotik RouterBoard 333
Message-ID: <20080715014149.GH26640@yookeroo.seuss>
References: <20080708042631.GB7328@yookeroo.seuss>
	<4ca5bd814ebc5d76508d40503f4884db@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ca5bd814ebc5d76508d40503f4884db@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 02:17:36AM +0200, Segher Boessenkool wrote:
>> Its firmware apparently provides a flattened device tree to the OS.
>> And while this step towards world domination is flattering, it's an
>> example of what I feared when people first got enthusiastic about the
>> idea of including flattened device trees in firmwares.  The tree has
>> not, AFAIK, been past this list, and has apparently not been reviewed
>> by someone knowledgeable about device trees.  In short, it's crap, and
>> now that it's embedded in the firware we can't really fix it.
>
> Can't you build a kernel with a blob that overrides the
> firmware-provided blob?

Sorry, my phrasing was slightly unclear.  Certainly we can work around
a firmware with a crap device tree by replacing it, if necessary.
Basically that's just treating the firmware as though it's one of
these old-style jobs which provides its tiny handful of necessary bits
of information (memory size, maybe a few others) in a format that
happens to resemble a device tree.

But it seems kind of silly for firmware to go to the trouble of
providing a device tree just for us to ignore it and substitute our
own.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
