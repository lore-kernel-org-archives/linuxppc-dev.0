From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>,
	<linuxppc-commit@source.mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Date: Mon, 8 Apr 2002 19:40:19 +0100
Message-Id: <20020408184019.9367@smtp.wanadoo.fr>
In-Reply-To: <20020408185758.GA21725@opus.bloom.county>
References: <20020408185758.GA21725@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Won't that still lead to an:
>#ifdef CONFIG_x
> ... set thingsup for CONFIG_X since this will only exist on CONFIG_x...
>#endif
>
>Or am I missing something?

Yes, though it will be separated from the actual code, and I'm
thinking about eventually auto-generating it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
