Date: Sat, 29 Jul 2000 09:38:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
Message-ID: <20000729093817.C4552@opus.bloom.county>
References: <39821DD7.ED0DA0A2@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39821DD7.ED0DA0A2@embeddededge.com>; from dan@netx4.com on Fri, Jul 28, 2000 at 07:57:11PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 28, 2000 at 07:57:11PM -0400, Dan Malek wrote:

> So, the 2.4.0 PowerPC tree is now Mac workstation only?  Please,
> we can't make the assumption that CONFIG_PPC is a Macintosh.  It
> breaks all PowerPC embedded systems (or anything that isn't a recent
> Mac with USB).  There is a CONFIG_MAC, isn't that enough to do the same
> thing?

Well, where are the specific breakages?  (CONFIG_MAC is used for 68k only
right now, IIRC.)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
