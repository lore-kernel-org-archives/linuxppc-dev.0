Date: Thu, 28 Jun 2001 04:52:53 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: jtm@smoothsmoothie.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <20010626160844.A20988@shamus.smoothsmoothie.com>
Message-ID: <Pine.LNX.3.95.1010628045135.5112D-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did yo ever get a reply to this? That sounds like just what I want to do
(well, it sounds just like what our vxworks code does to do what I want to
do, which I guess is good enough).

TIA,
--Gus

On Tue, 26 Jun 2001 jtm@smoothsmoothie.com wrote:

>
> I am looking for a solution to a similar problem. I am writing a
> driver for an FCC on the 8260 in transparent mode, and need
> to allocate buffer memory. The buffer memory will get filled
> via DMA, and therefore must not be cached. Will the following work
> correctly?
>
> 	vaddr = kmalloc(BUF_SIZE, GFP_DMA);
> 	paddr = __pa(vaddr);
>
> Thanks.
> --
> Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
> monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
> 		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
