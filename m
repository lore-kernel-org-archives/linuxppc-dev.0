Date: Mon, 25 Sep 2000 11:03:59 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <14798.23332.833379.615321@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 3.  On the same machine, the ati driver I built yesterday hoses linux
> completely and doesn't leave a core file.  I'm happy to help the
> developers try to debug this, but I'm not sure what information I can
> provide in this situation (it's also not my machine, so I can't always
> crash it at will).

Does the X server complain about PCI resource conflicts when run as X
--probeonly? Anything about PCI problems in the server log?

If so, send the output of lspci -vv.

BTW: Can you use yaboot for booting?

> 4. On the rev. b beige G3 w/Mach64 Rage Pro, the ati driver seems to
> be working.  The XF probe still gets the wrong amount of vram, and it
> still throws away the mode I constructed via fbset -x.  But it finds

Perhaps the video RAM detection typo which should be gone now ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
