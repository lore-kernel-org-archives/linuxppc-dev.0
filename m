Date: Fri, 29 Sep 2000 19:33:10 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: R Shapiro <rshapiro@bbn.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <Pine.LNX.4.21.0009282015220.15193-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10009291932370.7428-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> PS> Any ideas why writing to a disabled pci device in ppc crashes
> the machine but not the x86 ones ? Is this something that can be fixed
> in the kernel or an arch thing ?

Because it happens by the framebuffer driver (kernel space).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
