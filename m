In-Reply-To: <Pine.HPX.4.10.10001211502220.18916-100000@gra-ux1.iram.es>
Date: Fri, 21 Jan 2000 16:29:56 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000121162956.007813@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 21, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>Bridges also may reorder writes and burst them, eieio can be used to
>prevent this. That's not only the processor effect...

My understanding of the PCI spec is that bridges are not allowed to
re-order. They an combine for burst but they are forbidden to do any
reordering.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
