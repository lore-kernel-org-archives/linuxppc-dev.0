Date: Mon, 16 Apr 2001 17:00:42 +0100
Subject: Re: [PATCH] gettimeofday stability
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org, Samuel Rydh <samuel@ibrium.se>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010416160035.777CF2F0D3@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I still object strongly to anything touching the timebase, however.

I'd prefer if it wasn't touched too... I've used it in both the IRQ blocking
measurement stuff (yet to be ported to 2.4.x) and the Audio Latency
measurement stuff (PPC port of Benno Sennoner's stuff)...

I thought I could rely on TB ;-))

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
