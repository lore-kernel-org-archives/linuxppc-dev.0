From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-general@lists.terrasoftsolutions.com>
Subject: Re: dmasound audio patch
Date: Mon, 8 Apr 2002 19:45:24 +0100
Message-Id: <20020408184524.14156@smtp.wanadoo.fr>
In-Reply-To: <20020408152350.5fe654da.billfink@mindspring.com>
References: <20020408152350.5fe654da.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I halfway understand the reasoning but I don't really agree with it.
>I don't see any significant problem with doing the byte swapping in
>the kernel.  From an engineering standpoint, it seems to make more
>sense to me to do this common function once in the kernel driver rather
>than redoing it over and over in every audio app, and keep getting bit
>by the same endianness problem over and over again.  Linus and the PC
>world don't have to worry about it, but us PPC types keep getting a
>delay in usable audio apps as a result.
>
>Oh well, I know I'm tilting at windmills here.  :-)

No, here you are hitting the lack of proper audio architecture
in linux ;)

It's not the kernel work, definitely, to do any munging on samples
even if it is as simple as byteswap. It's the role of a userland
based process to do mixing & format conversion. I hope alsa will
finally provide something around those lines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
