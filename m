Subject: Re: Problems with dma_alloc_coherent()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <16493.61242.908659.82167@cargo.ozlabs.ibm.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401100546.A27472@home.com>
	 <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com>
	 <20040401185956.GB3786@gate.ebshome.net>
	 <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org>
	 <20040401220018.GA4130@gate.ebshome.net>
	 <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <16493.61242.908659.82167@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1080977598.7999.791.camel@newt>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 08:33:19 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-02 at 23:54, Paul Mackerras wrote:

> If you want to write code to handle a separate DMA controller, go
> ahead.  You will need to design your own separate API for it.  I
> wouldn't try to make it too general, though, since there are very few
> systems these days that have DMA controllers (as distinct from
> bus-master capable I/O devices).

Actually, they are extremely common in the embedded market. On my desk I
have three Linux systems with this class of DMA engine: an MPC107/7410,
an ARM9 from Cirrus, and an ARM9 from TI. Most system-on-a-chip
processors have DMA engines which can move between any two of memory,
PCI, and internal peripherals.

- Adrian Cox


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
