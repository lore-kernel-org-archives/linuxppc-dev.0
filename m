In-Reply-To: <Pine.HPX.4.10.10003101341450.22162-100000@gra-ux1.iram.es>
Date: Fri, 10 Mar 2000 14:14:34 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith r128
Message-Id: <20000310141434.019878@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 10, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>What do you mean with x100 ? Is it a series of PMAC models ? sync and
>eieio perform an address-only bus broadcast that should be terminated by
>the host bridge but never to the PCI bus so they can't crash HW. Is the
>host bridge/memory controller really that buggy ?

Those machines are also known as the NuBus PowerMacs. The adress only
cycle is broadcast on their bus and makes some of Apple's AV cards crash.

>And isync is not irrelevant on any processor since a) it flushes the
>instruction queue and b) it ensures that the effect of all previous
>instructions on machine state is taken into account before the next
>instruction executes (that's important if you change context by changing
>segment registers or modify some MSR bits).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
