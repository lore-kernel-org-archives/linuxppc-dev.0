Date: Thu, 3 Aug 2000 00:02:27 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Dan Malek <dan@netx4.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <39860A50.E423F099@embeddededge.com>
Message-ID: <Pine.LNX.4.10.10008021759180.14639-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Given the flexibility I was used to on m68k[*], I find this a pity as well...
>
> Well, it looks like I opened up a big can of worms...........
>
> I guess this is something that will get discussed as part of
> "restructuring" the PowerPC source tree when we jump into 2.5.xx.

While I also enjoyed the flexibility on m68k, some of it was paid for in
terms of increased complexity in head.S and entry.S (and especially head.S
wasn't a bit pretty). I'm not sure how your trouble with the embedded
systems can be solved, we kept separate head.S versions for Macs and other
machines for a while as well because things just got too confusing. Maybe
we need to keep separate versions for embedded and other systems here?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
