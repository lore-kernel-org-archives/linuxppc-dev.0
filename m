Date: Sun, 21 Oct 2001 20:28:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
Message-ID: <20011021202843.B4933@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD38515.40808@metaparadigm.com> <20011021195758.E1419@cpe-24-221-152-185.az.sprintbbd.net> <3BD39166.7020600@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD39166.7020600@metaparadigm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 11:24:22AM +0800, Michael Clark wrote:
> Tom Rini wrote:
>
> >On Mon, Oct 22, 2001 at 10:31:49AM +0800, Michael Clark wrote:
> [snip]
> >>Why does the eth0 link come up so late? Is it possible to make the
> >>broadcom driver wait for link before returning from the initialisation
> >>function?
>
> Okay, changed to BMAC and it works okay - should BMAC detection come
> before GMAC?

Er, say again?  And ignore what I just sent out (got confused fer a
second).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
