Message-ID: <38E371AA.B371660E@embeddededge.com>
Date: Thu, 30 Mar 2000 10:24:26 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another try at the run-from-Flash issue for MPC8xx/MBX/custom
References: <BE1C564723B3D21191FD0000F840E39801D81482@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:
>
> I agree, 40 seconds is too long: he must be doing something wrong.
> But even 5 seconds is annoyingly long for an embedded system.

That's for compressed kernel and initrd.  I wanted to compare apples
to apples.

You can put an uncompressed kernel and ROM file system in the Flash.
Just copy the kernel (or kernel data) to RAM and you are all set.  That
should boot pretty fast.

The trouble with using Linux is you have lots of choices.  You actually
have to _think_ about which is best for you and how you want to
implement the solution.  I don't particularly like other software
packages that proclaim "we did it for you", hide the code in a binary
somewhere, and you spend your time working around their rules.

With all of the GUIs and "click here to make it happen", people have
forgotten (or never learned) to think for themselves.  I have yet to
find a (reasonable) product requirement that can't be solved with Linux.

I implement what is useful to me and my customers.  If you want
something else, and it isn't there, just do it.  I'm not going to
guess at what you may want.  My challenges have been systems with
lots of RAM and not much Flash ROM.  If you can actually purchase
the flash ROM and are happy with the high prices, go ahead and load
it up.

(I am not picking on you David, this is just a summary of past
messages :-).




	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
