From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199909221103.NAA30114@amber.biophys.uni-duesseldorf.de>
Subject: Re: USB driver not detecting mouse? (lots of detail)
In-Reply-To: <199909220216.TAA00607@falcon.csc.calpoly.edu> from Ira K Weiny at "Sep 21, 1999 07:16:01 pm"
To: iweiny@falcon.csc.calpoly.edu (Ira K Weiny)
Date: Wed, 22 Sep 1999 13:03:56 +0200 (CEST)
Cc: hay@colorado.edu, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Sep 21 17:56:24 batcave2 kernel: floating point used in kernel (task=c2554000,
> pc=cc83ddd0)
> Sep 21 17:56:24 batcave2 kernel: mouse.c(387): mouse resume
> 
> I don't know what the floating point used in kernel message is?  I have been
> looking into that.

Did you compile your module with -msoft-float?

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
