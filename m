Message-ID: <3B9D190A.5C227976@denise.shiny.it>
Date: Mon, 10 Sep 2001 21:48:26 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: "Marcus H. Mendenhall" <mendenmh@telalink.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mvista tree
References: <200109090459.XAA25323@lists.linuxppc.org> <p04330100b7c26acbf9cc@[129.59.235.75]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This is probably the same problem which caused me much grief for
> about 2 weeks.  Check that in .config, this first  xxxIDE_DMAxxx
> option is turned on, along with the PCI_IDE_DMA and anything
> mentioning PPC/powemac.  I would be more specific, except I am not
> sitting next to my kernel .config file right now (it's at home).
> The PCI IDE DMA code depends on this earlier option to avoid many
> unresolved symbols.

Well, up to 2.4.7 I had no probs with the same .config .

I enabled some more options in the IDE page and it's OK now.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
