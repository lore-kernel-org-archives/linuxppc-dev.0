Message-ID: <3AF748FF.E308BF0C@mvista.com>
Date: Mon, 07 May 2001 21:16:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: machael thailer <dony.he@huawei.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel...
References: <5.0.2.1.0.20010508085652.00a4aec0@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:

> I have the same problem on an FADS board.

What "same" problem?  How are you loading and tracing the kernel?

> ......... So it maybe works if the image
> is used without bootloader or by changing head.S.

The image certainly won't work without any bootloader, whether it
is PPCBoot or the code found in arch/ppc/mbx (or arch/ppc/boot/mbx
depending on your source base).  The kernel requires a bunch of
registers and information set up before it is called, and one of
those two methods must be used to ensure this happens.

I believe there is a working FADS port in the FSM Labs BitKeeper
sources.  If not, you can download the older 2.4.0-test2 LSP from
MontaVista and use it as a guide for updating a later kernel.  The
changes are very minor.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
