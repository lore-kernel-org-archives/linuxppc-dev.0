Date: Mon, 22 Oct 2001 08:41:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Clark <michael@metaparadigm.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
Message-ID: <20011022084148.G4933@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD39166.7020600@metaparadigm.com> <20011022131636.2681@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011022131636.2681@smtp.adsl.oleane.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 03:16:36PM +0200, Benjamin Herrenschmidt wrote:
> >Okay, changed to BMAC and it works okay - should BMAC detection come
> >before GMAC?
>
> There is no way bmac would replace gmac, those are different drivers
> for different chips.

But would bmac ever try and init some gmac hw?  That's sort of what it
sounded like Michael was saying.  But anyhow, gmac and bmac use the
module_init bits and thus there's no way to enforce ordering of init.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
