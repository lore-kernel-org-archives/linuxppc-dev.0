Date: Sun, 21 Oct 2001 20:28:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
Message-ID: <20011021202813.A4933@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD38515.40808@metaparadigm.com> <20011021195758.E1419@cpe-24-221-152-185.az.sprintbbd.net> <3BD38FC3.8040206@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD38FC3.8040206@metaparadigm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 11:17:23AM +0800, Michael Clark wrote:
> Tom Rini wrote:
>
> >On Mon, Oct 22, 2001 at 10:31:49AM +0800, Michael Clark wrote:
>
> >>Why does the eth0 link come up so late? Is it possible to make the
> >>broadcom driver wait for link before returning from the initialisation
> >>function?
> >>
> >
> >What driver did you use?
>
> Not exactly sure: I have MACE, BMAC and GMAC compiled in. After matching
> the log messages to the dirver source, it looks like GMAC.

If you're using _devel or benh's tree, turn those off and try sungem.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
