Date: Tue, 28 May 2002 13:18:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Hymod board support and related changes ...
Message-ID: <20020528201810.GA5997@opus.bloom.county>
References: <17991.1022564915@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17991.1022564915@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 03:48:35PM +1000, Murray Jensen wrote:

> - Hymod board support

For the m8260_gorom() call, try using spin_lock_irqsave() instead of
save_flags();cli() ... restore_flags();

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
