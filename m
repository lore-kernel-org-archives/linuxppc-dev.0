To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Occasional crash reports
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 14 Aug 2001 18:02:15 +0200
Message-ID: <4vg0auiq9k.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> So basically, the kernel tends to die in various locations where things
> should be just fine, but I did notice one thing: In most of these cases,
> I had softirq around in the backtrace (either running in softirqs, or
> having do_softirq() in the backtrace). There is one case where I didn't
> have it: it dies inside power_save(), so probably because an interrupt
> that happened just before messed things up.
>
> I'm wondering if we might be running into some stack overflow...
>
> Any clue ?
>
> Ben.

Hi,

I haven't observed any problem with recent kernels from your tree with
power supply. When running on battery kernel crashes soon (usually by
15 minutes). This is on my Pismo (March 2000) with 2.4.7-ben0. On the
second thought it might be related to USB as well as I'm not using
battery and USB mouse uncorrelated - IIRC one crash occurred inside
hc_interrupt. I'll rsync and see what's the current status.

cheers,
        Jiri

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
