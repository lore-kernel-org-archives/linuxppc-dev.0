Date: Thu, 24 Jan 2002 11:20:05 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut base board PCI problems
Message-Id: <20020124112005.75d4b366.iweiny@acm.org>
In-Reply-To: <20020118191321.7708fdaf.iweiny@acm.org>
References: <20020118191321.7708fdaf.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all for you help.

It turns out that the one board which was working had correct strapping with
the PCI Sync clock at 33MHz.

A mix up in manufacturing allowed our other boards to be straped with a 16MHz
clock.  For those of you who don't know even if the PCI bus is in Asyncronous
mode the Sync clock must be >= to the bus speed.  In our case 33MHz.

Thanks so much for the input, it is always the simple ones which are hard to
find.

Ira Weiny
iweiny@acm.org

On Fri, 18 Jan 2002 19:13:21 -0800
Ira Weiny <iweiny@acm.org> wrote:

>
> It has been some time since I have written to the list with a question so
> forgive me if this deficient in some way.
>
> We have a custom 405GP board which is basically a Walnut platform minus some of
> the peripherals like keyboard/mouse, FPGA, etc.
>
> We manufactured 10 boards and one works.  The others all display the same
> behavior below.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
