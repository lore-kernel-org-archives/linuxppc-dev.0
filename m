Message-ID: <39C79BBF.5D34BD5E@mvista.com>
Date: Tue, 19 Sep 2000 13:00:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb/Sandpoint -- patch & help needed
References: <alexsh@hectic.net> <7803.969334757@msa.cmst.csiro.au> <20000919193930.C1406@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:

> Right, but before calling setup_arch, it prints the linux kernel
> banner! Here's the code:

The kernel "prints" lots of stuff, and it all goes into a buffer,
to emerge quite late in the boot process when the (serial)
console port is initialized for real use by applications.


> And I don't see the banner. Did you see it when you encountered this?

You should see a 20 character (or so) ASCII string of coded information
appear on the serial port used for GDB.  The system stops at this
point, waiting to hear from GDB (as you have already discovered).


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
