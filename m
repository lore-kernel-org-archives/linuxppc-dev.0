From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ATI Radeon 32MB PCI, Apple 17 Flat panel on B+W G3
Date: Sat, 6 Oct 2001 19:11:07 +0200
Message-Id: <20011006171107.14805@smtp.wanadoo.fr>
In-Reply-To: <20011006091632.B10546@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011006091632.B10546@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I will give them a try.
>
>Radeon framebuffer support is also in -linus finally, so all of the
>trees should support it.

The version in -linus is slightly outdated afaik. Also, you may have
to do the usual tweak to get the PLL right ;) (very similar to r128).

Ani and I have found some ways to fix that PLL issues once for all
(basically, we have some code to really probe the refclk), and afaik,
ATI OF drivers for radeon will actually give that info in the device
tree (finally !).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
