Message-ID: <39C822D7.93126A84@ncal.verio.com>
Date: Tue, 19 Sep 2000 19:37:11 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: dual G4 time issues..
References: <39C518A9.2BA320DA@ncal.verio.com> <20000918090710.14056@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
>
> I had reports of pthread-intensive applications having the threads
> randomly "hang" when running on the SMP 2.2.x kernel. This happens on PPC
> only (works fine with the same kernel on x86) and it's fine on UP.
>

I'll look into getting a serial port on this machine so I can
try some debugging. Any recommendations what sort of PCI I/O
card would work best, or would one of those gadgets that
replaces the modem be a better bet? I'll guess I should
also look into the modem cross-over cable trick.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
