Message-Id: <200005301406.QAA00783@piglet.grunz.lu>
Date: Tue, 30 May 2000 16:06:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: fbconsole and 2.4.0test1-ac4
To: Henning.Loeser@Physik.Uni-Marburg.DE
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.4.02.10005301307540.26677-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Henning,

On  30 May, this message from Henning Loeser echoed through cyberspace:
> as I wrote I switched to 2.4.0-test1-ac4 sources hoping to get my ide-card
> to work

There's little difference between late 2.3.99 kernels and the 2.4.0-test
series. In fact, apart from specific bug fixes, they're the same.

> There is still another issue with 2.4.0 I do have to start the Mac with
> extensions disabeled, then activate the G3 cache via a controllpanel and
> then use the BootX Application. If I start with extensions the kernel
> crashes when it tries to start the System logger. Any hints on that ? It
> does boot a 2.2.15 kernel without problems with the extensions enabeled!

I don't know why it crashes, but this patch:

http://www.cpu.lu/~mlan/linux/index.html#l2cr

might help you. It adds a kernel command line parameter for setting the
l2cr value, i.e. enabling the cache, even if you don't boot 'through'
MacOS.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
