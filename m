Message-ID: <3912F591.6F6AE305@embeddededge.com>
Date: Fri, 05 May 2000 12:23:45 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: interference between scc serial and ethernet: more information
References: <BE1C564723B3D21191FD0000F840E39801D81505@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:

> It's a 50MHz MPC860, identified by 8xxrom as XPC860xxZPnnC1 and actually
> stamped as XPC860ENCZP50C1.  Running at 50MHz.

There shouldn't be any trouble with that part.

Since this is a custom board, what software changes have you made?
What board configuration file are you using?  What changes did
you make to commproc.h to support your Ethernet configuration?

Send me all of your changes (i.e. diff the sources), or post them
or something.  This kernel on something like the Embedded Planet CLLF
runs just fine with Ethernet and PPP on multiple serial ports.  Show
the changes and maybe we can help.  I certainly can't guess any more.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
