Date: Sat, 20 Jan 2001 14:21:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Chris Emerson <cemerson@chiark.greenend.org.uk>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <19341214191016.27444@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.30.0101201420040.18939-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Very hard work indeed :) You'd have to write a mecanism to let most of
> the OHCI controller code to run in a polled way from within the
> debugger... quite nasty.

Why? How's that different from ADB keyboards? It just won't work when
interrupts are dead ;-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
