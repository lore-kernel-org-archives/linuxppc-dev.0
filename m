Date: Mon, 8 Apr 2002 15:23:50 -0400
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: dmasound audio patch
Message-Id: <20020408152350.5fe654da.billfink@mindspring.com>
In-Reply-To: <20340714231722.28828@smtp.adsl.oleane.com>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
	<20340714231722.28828@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 15 Jul 2034, Benjamin Herrenschmidt wrote:

Hi Ben,

Gee you're a very futuristic kind of guy (see timestamp above).  :-)

> Hi Bill, thanks for the patch, though I decided long ago I agree with linus
> and that swapping shouldn't take place in the kernel. If we go that way, we
> make sure userland apps will never be fixed ;)

I halfway understand the reasoning but I don't really agree with it.
I don't see any significant problem with doing the byte swapping in
the kernel.  From an engineering standpoint, it seems to make more
sense to me to do this common function once in the kernel driver rather
than redoing it over and over in every audio app, and keep getting bit
by the same endianness problem over and over again.  Linus and the PC
world don't have to worry about it, but us PPC types keep getting a
delay in usable audio apps as a result.

Oh well, I know I'm tilting at windmills here.  :-)

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
