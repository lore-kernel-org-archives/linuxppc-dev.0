Date: Fri, 7 Jun 2002 12:38:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: can/should we use gcc 3.1 to compile kernels
Message-ID: <20020607193833.GO14252@opus.bloom.county>
References: <200206081337.31359.kevin.hendricks@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200206081337.31359.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 08, 2002 at 01:41:12PM -0400, Kevin B. Hendricks wrote:

> Has anyone successfully used gcc 3.1 or gcc 3.1.1-pre to build actual
> working kernels and tested them?
>
> Does it work?

There's at least a few people who've done it.  Personally I'll be using
2.95.3 (or 2.95 from CVS) until forced to do otherwise, just because
it's the most well-tested compiler.

That said, if you do use 3.1, you'll get a bunch more warnings which I
don't think you can turn off, which has kind of annoyed some developers.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
