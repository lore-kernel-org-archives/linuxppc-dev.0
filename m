Date: Mon, 20 Mar 2000 17:30:32 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Lombard ehternet controller
In-Reply-To: <01BF923A.75F963E0.jween@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10003201719550.8229-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Sorry, I didn't pose the question right. When using linuxconf to configure
> the kernel to support the ethernet device it asks you which "kernel module"
> to use for your particular card (3c501, 3c59x, apricot etc). Since the

That would be the name of the module file, without the .o -> bmac

> Lombard has ethernet built in and I can't figure out which chip Apple used
> I don't know which "module" to select. BMAC doesn't seem to be one of the
> choices available. Is there a patch to add it on?

The name of the module is bmac. The name of the chip as it identifies on
boot is BMAC, look at your boot messages and at /lib/modules/<kernel
version/net/. If the kernel reports BMAC on boot the driver is compiled
in. If there's a bmac.o in the module directory it's built as module.
Otherwise it's missing and you need to build a new kernel. If the module
is present and linuxconf still doesn't show it, linuxconf is broken.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
