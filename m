Date: Wed, 18 Apr 2001 15:29:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: iweiny@pacbell.net
Cc: linuxemb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Walnut IDE support
Message-ID: <20010418152914.E13403@opus.bloom.county>
References: <200104182216.PAA02532@batcave2.batcave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200104182216.PAA02532@batcave2.batcave>; from iweiny@pacbell.net on Wed, Apr 18, 2001 at 03:16:08PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 18, 2001 at 03:16:08PM -0700, iweiny@pacbell.net wrote:

> I am trying to get a Promise Ultra66 IDE card running on the Walnut board.
> The kernel recognizes the card but gives the following errors.
>
> PDC20262: IDE controller on PCI bus 00 dev 08
> PDC20262: device not capable of full native PCI mode
> PDC20262: device disabled (BIOS)
>
> Is there a configuration setting or kernel param I am missing?

First, you did enable CONFIG_BLK_DEV_PDC202XX right?  It's quite possible
that the driver cannot initalize the card w/o the BIOS (on the card) having
done something.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
