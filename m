From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Marcus H. Mendenhall" <mendenmh@telalink.net>,
        <linuxppc-dev@lists.linuxppc.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: (more) 2.4 problems / G4/500/1GB dual processor / USB
Date: Fri, 1 Sep 2000 16:42:38 +0200
Message-Id: <20000901144238.2387@mailhost.mipsys.com>
In-Reply-To: <20000901144114.29642@mailhost.mipsys.com>
References: <20000901144114.29642@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>>I get a series of PCI address conflicts when probing the PCI bus
>>which result in my ethernet card not being able to be turned on. I am
>>not using the built-in GMAC, but an older Apple 10/100 PCI card. This
>>does not happen with the linux-pmac-stable kernel.
>
>With recent kernels, GMAC works nicely. Several people (including me) are
>working on solving those PCI problems.

Oops, I didn't notice you were using a dual-G4. I've not yet merged the
GMAC changes for this machine in 2.4, but if you rsync my current 2.2
tree, you should have a working GMAC driver (and no PCI conflicts BTW).
I'm waiting for some older patches to be accepted by Linus before hacking
more on the bk tree.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
