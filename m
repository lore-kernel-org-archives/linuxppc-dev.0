Date: Mon, 3 Dec 2001 08:29:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bill Fink <billfink@mindspring.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Message-ID: <20011203082937.S7819@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.33.0112030257230.5627-100000@gwiz.nasa.atd.net> <20011202235953.3323@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011202235953.3323@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 03, 2001 at 12:59:53AM +0100, Benjamin Herrenschmidt wrote:

> Same problem, the information there is driver specific and the

I prefer feature. :)

> tool currently use a fix offset instead of properly handling the
> nvram device tree extension format (afaik). The cmode is also a
> driver specific thing and is equivalent to the MacOS driver
> "DepthMode" setting, which will map differently to bit depths
> depending on the MacOS driver you are dealing with.

If we're writing at a fixed location, and reading from a fixed location,
wouldn't it work (albiet not happily with MacOS?).  That's what I was
getting at.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
