Date: Thu, 27 Jun 2002 08:34:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>,
	Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LG_L1_CACHE_LINE_SIZE in linuxppc-2.5
Message-ID: <20020627153438.GB26734@opus.bloom.county>
References: <3D1AB921.2020003@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D1AB921.2020003@elsoft.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 27, 2002 at 09:05:05AM +0200, "David M?ller (ELSOFT AG)" wrote:

> Shouldn't "LG_L1_CACHE_LINE_SIZE" in asm-ppc/cache.h be renamed to
> "L1_CACHE_SHIFT".

Based on the only user (which is doing an srwi rX,rX,LG...) I should
think so..  Paul?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
