From: Benjamin Herrenschmidt <bh40@calva.net>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>,
        <cort@fsmlabs.com>
Subject: Re: Sys Call Numbers
Date: Sat, 8 Jul 2000 18:40:26 +0200
Message-Id: <20000708164026.4439@192.168.1.10>
In-Reply-To: <200007081623.RAA32155@hyperion.valhalla.net>
References: <200007081623.RAA32155@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I did a patch to allow Jun Sun's IRQ Latency testing code to be used on
>2.2.17pre7 et. al.
>
>Today I came to apply it to Ben H's pre10 - to find that the sysCall number
>Jun had used was no longer 'available' (listed as MacOnLinux use).
>
>Is this just a 'hazard' or is there some way of knowing where to allocate a
>syscall number.
>
>(It's not a big point - there's only one #define to change - but, then
>again....)

There's currently a mess with syscall numbers on the PPC arch, partially
because the syscall userd by MOL was never "reserved" in the kernel tree,
because I did my own hacking on special syscalls and forgot to remove my
added syscalls from my released pre9/pre10 kernels, and partially because
of some miscommunication when the LFS patches were applied.

This should be sorted out soon.

(BTW. Cort ? Any answer about my need for 4 reserved syscalls ?)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
