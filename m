From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Clark <michael@metaparadigm.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
Date: Mon, 22 Oct 2001 15:16:36 +0200
Message-Id: <20011022131636.2681@smtp.adsl.oleane.com>
In-Reply-To: <3BD39166.7020600@metaparadigm.com>
References: <3BD39166.7020600@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Okay, changed to BMAC and it works okay - should BMAC detection come
>before GMAC?

There is no way bmac would replace gmac, those are different drivers
for different chips.

The time it takes for the phy to negociate is nothing I can do about.
It's probably an ipconfig design bug not to wait long enough here :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
