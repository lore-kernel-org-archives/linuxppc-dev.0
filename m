Message-ID: <19981207111226.A2909@tiktok.cygnus.com>
Date: Mon, 7 Dec 1998 11:12:26 -0500
From: Michael Meissner <meissner@cygnus.com>
To: jeramy <jsmith@ixl.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EGCS 1.1.1 FYI
References: <366A3B16.48093C74@ixl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <366A3B16.48093C74@ixl.com>; from jeramy on Sun, Dec 06, 1998 at 02:06:46AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 06, 1998 at 02:06:46AM -0600, jeramy wrote:
> 
> Cygnus released 1.1.1 on Dec. 1 with the following PPC specific
> improvements.

Note, while we host the egcs machines (and provide a number of compiler
hackers), EGCS != Cygnus.  EGCS is netwide and has people from many different
organizations (including most of the developers from the FSF GCC, and many more
developers that were never part of the FSF).

> Fixed PPC/RS6000 LEGITIMIZE_ADDRESS macro and bug in conversion from
> unsigned ints to double precision floats. 
> Fixed handling of long longs for varargs/stdarg functions on the ppc. 

Note, this means any code that passes long long should have both the caller and
callee recompiled with the same compiler.

> Fixed code generation problems with gpr<->fpr copies for 64bit ppc. 

That doesn't affect PowerPC Linux right now, since the only 64-bit ppc target
is AIX based (there are a number of issues like gas/ld support, and machine
availability before it will matter to Linux/PPC).

> Makes sure target libraries build with -fPIC for PPC targets.
> 
> Good to see this much platform specific progress in a x.x.1 release. :)

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
