Date: Wed, 1 Oct 2003 14:48:32 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to Put Ethernet MAC Addresses?
In-Reply-To: <20031001153209.D688@borg.org>
Message-ID: <Pine.LNX.4.44.0310011446270.23959-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 1 Oct 2003, Kent Borg wrote:
> In boards where there is ethernet but no manufacturered in MAC address
> in the ethernet hardware, where does one get it?  Does this become a
> userland problem to be handled in init scripts?  It seems that
> ethernet initialization could also set the "manufacturer" MAC address,
> and it might be stored in flash next to the Linux image, or in some
> extra SPD bits, etc.
>
> What are the various right ways to do this?

Serial PROM.

Check if the ethernet part allows reading the MAC directly from
a small serial PROM. Many board manufacturers have processes for
programming serial proms for this type of thing.

Otherwise, just have the processor read the serial PROM and program
it into the ethernet MAC.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
