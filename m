Message-ID: <3A4D079E.1778BCEC@mvista.com>
Date: Fri, 29 Dec 2000 16:52:30 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A stable linux 2.2.xx for sandpoint-8240 anywhere?
References: <000501c071cd$44356c00$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:

> There are problems as this port was based on an experimental and unstable
> kernel.
> There are patches (tons) that fix some of the problems we've been seeing,

Really?  Although not suitable for a product, there shouldn't be "tons"
of patches required to make it useful in a development environment.
There may be patches required to work around the different revisions
of the Sandpoint hardware.

> We're facing a deadline and must concentrate on a custom driver for now.

That is where all of the resources seem to be going right now, to
custom hardware.  The 8240 is just a 603 with 106/107 OpenPIC PCI
bridge.  The Sandpoint is what required all of the code changes.  If
your hardware is like a Sandpoint, then there are still changes
required to suit your needs.  Most people aren't building Sandpoint-like
hardware that I know about.

> Eventually we'll make our patches for 8240 available.

Do it quickly, as there will soon be 824x updates in the 2.4 kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
