From: dank@kegel.com
Message-ID: <2767.64.165.195.65.1070467346.squirrel@webmail.pair.com>
Date: Wed, 3 Dec 2003 11:02:26 -0500 (EST)
Subject: Re: quick survey only for PowerPC 405 folks
To: <cjohnson@gcctech.com>
In-Reply-To: <3FCE04E3.9080602@gcctech.com>
References: <3FCE04E3.9080602@gcctech.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm trying to stabilize some tools and OS components, and would like
> your recommendations - you can reply directly to me if you like.
>  Thanks!  Currently my target processors are 200mHz 405GP and 333mHz
> 405GPr on a custom-designed board.  We are already running 2.4.23-rc1 on
> the board with our own bootstrap.
>
> 1. Kernel version:

2.4.21, 2.4.17

> 2. Kernel obtained from:

linuxppc_dev_2_4
(but given the good reports about vanilla kernel.org 2.4.23,
maybe there's hope for ditching linuxppc_dev_2_4 eventually)

> 3. gcc version:

montavista hardhat 2.0's gcc 2.95 for kernel,
vanilla gcc 3.0.4 for apps,
but moving to gcc 3.3.2 for everything (though
that may be on hold until something forces them,
since I just left the company)

> 4. glibc version:

montavista hardhat 2.0's glibc-2.2.3,
but moving to glibc-2.2.5 or maybe glibc-2.3.2

> 5. binutils version:

oh, heck, I forget

> 6. Did you build your own toolchain?

yes, and I documented how I do it at http://kegel.com/crosstool
including workarounds for various compiler and glibc problems
like ppc405's friggin' erratum 77

> 7. If not, where did it come from?

we originally used montavista hardhat 2.0, still do
when building kernel, for the moment.

> 8. What is your development environment (editors, tools, debuggers,
> etc.)?

vi / emacs
gdb
oprofile (for ppc750, not sure if we have it running on pc405)
homebrew memory leak finder based on garbage collector

> 9. I have an Abatron, any useful magic I should know?

n/a.  I thankfully didn't have to do board bringup.

> 10. How do you manage building, configuring and delivering user-mode
> software for the target?

have custom makefiles for everything, but ready to
move to using ptxdist (http://ptxdist.sf.net)

> 11. Please pass along any comments on non-floating point -capable
> processors:

we were quite happy with ppc405 but have moved on to ppc750 etc
for new designs for integer performance.  Well, ok, erratum 77 sucked.

I'm no longer with the company in question, but
am still maintaining crosstool (though less intently)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
