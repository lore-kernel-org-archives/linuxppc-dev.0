Date: Mon, 22 Jul 2002 10:00:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Allen <gallen@arlut.utexas.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Directly accessing I/O ports
Message-ID: <20020722170038.GD692@opus.bloom.county>
References: <p05111b16b95d05434f09@[10.8.16.89]> <20020720181058.30333@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020720181058.30333@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 20, 2002 at 08:10:58PM +0200, Benjamin Herrenschmidt wrote:
>
> >For that matter, what's the *right* way to access this sort of thing
> >from userland?
[snip]

Or the other fix, which iirc Jeff Garzik has somewhere on his todo list
is to make it work with ethtool ioctls.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
