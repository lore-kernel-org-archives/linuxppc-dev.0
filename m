Date: Wed, 5 May 2004 17:47:48 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: ?????? <jazz0719@dreamwiz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Q]Ethernet problem on Walnut ref board(PPC405GP) using Kernel 2.6
Message-ID: <20040505174748.A21166@home.com>
References: <20040506001307.0000976E029002F4@mail0.dreamwiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040506001307.0000976E029002F4@mail0.dreamwiz.com>; from jazz0719@dreamwiz.com on Thu, May 06, 2004 at 09:13:07AM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 06, 2004 at 09:13:07AM +0900, ?????? wrote:
>
> I got problems to activate ethernet on Walnut ref board(PPC405GP) using Linux kernel v. 2.6.x
>
> In linuxppc_2_4_devel(http://www.denx.de) environment, it works fine and
> the ethernet is recognized from menuconfig setting below.
> Network device support --->
>   On-chip net devices --->
>     [*] IBM on-chip ethernet (which is ported by montavista)
> the source directory is drivers/net/ibm_emac/*
>
> BUT in linux kernel 2.6.5, there is no source included(drivers/net/ibm_emac) and
> no menuconfig option to select '[*] IBM on-chip ethernet '

Stock (kernel.org) 2.6 doesn't yet have an EMAC driver.

The linux-2.5-ocp and linuxppc-2.5 trees both have EMAC drivers (though
they are different drivers).

See http://penguinppc.org/dev/kernel.shtml for how to get the trees.
linux-2.5-ocp is at bk://source.mvista.com/linux-2.5-ocp

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
