Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: ATI Radeon 32MB PCI, Apple 17 Flat panel on B+W G3
Date: Sat, 6 Oct 2001 14:06:34 -0400
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <20011006091632.B10546@cpe-24-221-152-185.az.sprintbbd.net> <20011006171107.14805@smtp.wanadoo.fr>
In-Reply-To: <20011006171107.14805@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20011006180432.WQQC27768.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

> Ani and I have found some ways to fix that PLL issues once for all
> (basically, we have some code to really probe the refclk), and afaik,
> ATI OF drivers for radeon will actually give that info in the device
> tree (finally !).

If you send that patch along, I would be happy to test it for you.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
