Mime-Version: 1.0
Message-Id: <p04330100b7c26acbf9cc@[129.59.235.75]>
In-Reply-To: <200109090459.XAA25323@lists.linuxppc.org>
References: <200109090459.XAA25323@lists.linuxppc.org>
Date: Mon, 10 Sep 2001 08:07:31 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Marcus H. Mendenhall" <mendenmh@telalink.net>
Subject: re: mvista tree
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is probably the same problem which caused me much grief for
about 2 weeks.  Check that in .config, this first  xxxIDE_DMAxxx
option is turned on, along with the PCI_IDE_DMA and anything
mentioning PPC/powemac.  I would be more specific, except I am not
sitting next to my kernel .config file right now (it's at home).
The PCI IDE DMA code depends on this earlier option to avoid many
unresolved symbols.

Marcus Mendenhall

>------------------------------
>
>Date: Fri, 07 Sep 2001 22:32:39 +0200
>From: Giuliano Pochini <pochini@denise.shiny.it>
>Subject: mvista tree
>
>Ehm.. Am I the only one who get thes error compiling
>the stable tree from mvista ?
>
>
>drivers/ide/idedriver.o: In function `ide_unregister':
>drivers/ide/idedriver.o(.text+0x36ec): undefined reference to
>`ide_release_dma'
>
>Bye.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
