Message-ID: <3CB368FB.1010905@brocade.com>
Date: Tue, 09 Apr 2002 15:19:39 -0700
From: "Amit D. Chaudhary" <amitc@brocade.com>
MIME-Version: 1.0
To: steve.cameron@compaq.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM walnut, gcc, NIC and recent kernel?
References: <20020409153916.A5306@zuul.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Jim Duey sent a HOWTO to the list in Jan 2002 titled "Walnut(405GP)
Kernel Compiling HowTo". you might want to search the mailing list archives.
http://lists.linuxppc.org/index.html#search

Actually even I would be interested in knowing if you could get the
walnut board working with the kernel from ppc.bkserver.net.

It does help to have the latest kernel as it is easy to get support from
fellow developers, tends to be more tested and integration with other
software components is possible.

Regards
Amit



Stephen Cameron wrote:
> Hi,
>
> Lately I find myself playing around with this IBM walnut
> board and hardhat linux 1.2 with a 2.4.0 based kernel,
> cross compiling with Montavista's gcc on an intel box.
>
> I'd like to use a more recent kernel, but I have
> some questions.
>
> I downloaded 2.4.18 along with the powerpc patch from
> kernel.org.
>
> Then, changed the Makefile to set CROSS_COMPILE = to
> montavista's compiler, and ARCH = ppc.
>
> Then it seems the walnut's network driver turns up missing,
> so I tried copying over the *405*.[ch] files from the drivers/net
> directory of the 2.4.0 montavista kernel. (realizing that's
> probably not going to work straightaway) and hacked the
> Config.in to try to make it attempt a compile.
>
> Well, the assembler complained about some "unsupported
> relocation type" in ppc4xx_pic.o, so I suspect I need a
> newer gcc, assembler, etc. (had nothing to do with network
> driver, I think)
>
> So, it occurs to me that other folks must be using this walnut,
> and perhaps solved these problems already.
>
> So if someone has recommendations about a specific recent kernel
> that works well with the walnut, and has network support for it,
> that'd be nice.
>
> Also any hints on getting gcc & friends to work for intel->ppc
> cross compiler with a recent kernel would be appreciated.
>
> Also, if I'd be better off sticking with hardhat linux (or
> something else) for an embedded application than trying to
> use the kernel.org kernels for some reasons, please feel
> free to educate me about that.
>
> Thanks,
>
> -- steve
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
