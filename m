Date: Thu, 30 May 2002 13:10:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020530031050.GK16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax> <3CF4ED71.4040706@embeddededge.com> <3CF4FB77.3010203@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF4FB77.3010203@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 09:01:59AM -0700, Armin Kuster wrote:
>
> Dan Malek wrote:
>
> >We can't change the PCI names, so I just suggested we change the names to
> >consistent_sync(), define those in io.h (so non-PCI systems don't have to
> >include pci header files just to get a flag name), and put a big comment
> >around the flag definitions that they have to match the PCI_ names.
>
> Why not put the flag definition in a /linux/dma.h and include that in
> /linux/pci.h.  Have the pci flags be defined as the ones in dma.h.  That
> way it's obvious where the orginal defines are and easier to
> maintain. :)

That's what I'd like to do, but it means changes to generic code, so
Linus needs to be convinced.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
