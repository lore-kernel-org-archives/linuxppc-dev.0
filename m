From: Benjamin Herrenschmidt <bh40@calva.net>
To: <rboder@grn.georet.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linux-pmac-stable
Date: Mon, 5 Jun 2000 22:35:07 +0200
Message-Id: <20000605203507.502@192.168.1.10>
In-Reply-To: <393BF78C.1D3F10E1@grn.georet.net>
References: <393BF78C.1D3F10E1@grn.georet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 5, 2000, Ryan Boder <rboder@grn.georet.net> wrote:

>I am having trouble with the linux-pmac-stable source. I have a G4 AGP
>400MHZ. The problem is that for every kernel I compile, it begins
>booting but halfway through the process it freezes up and kgdb gives me
>this...

The linux-pmac-stable contains a weird USB stack that provides 2
different USB OHCI drivers: the OHCI, and the OHCI-HCD. You should make
sure you use the OHCI one, not the OHCI-HCD.

This has been all cleaned up in 2.3/2.4 series, we will probably make a
new USB backport for 2.2 once 2.4 is stable enough.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
