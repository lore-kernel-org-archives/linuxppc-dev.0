From: Benjamin Herrenschmidt <bh40@calva.net>
To: Dan Malek <dan@mvista.com>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BK 2.4-test8 PCI/USB/G4
Date: Mon, 18 Sep 2000 11:03:50 +0200
Message-Id: <20000918090350.7377@mailhost.mipsys.com>
In-Reply-To: <39C3F4DA.2363A35E@mvista.com>
References: <39C3F4DA.2363A35E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>For those of you using the latest 2.4 BitKeeper tree on a G4, I have
>a partial solution to making USB work again.  After pulling updates,
>simply 'bk get -r1.18 arch/ppc/kernel/pci.c', which will get the
>previous version of this file.  Build the kernel and at least you get
>the mouse/keyboard, X, and stuff like that again.  At least you can
>make progress on other tasks while we sort this out.

I've pushed a temporary workaround yesterday that re-enables the "old"
code via
a #define, at least until I've found what's wrong with Geert new code.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
