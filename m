Message-ID: <3B969F2C.D849D360@mvista.com>
Date: Wed, 05 Sep 2001 14:54:52 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Elan Feingold <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross GDB and core files
References: <NDBBLJKOJGKDOFBHNPGEMENACEAA.elan@nxnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Elan,
This was a problem with the 4.18 GDB. It was fixed in the HHL releases.
It is fixed in GDB 5.0x. from MontaVista.

Cal Erickson

Elan Feingold wrote:

> Hi,
>
> I'm trying to get gdb compiled with host of 386-linux and target of
> ppc-linux, mostly for debugging core files.  The ppc_8xx-gdb that came with
> hardhat doesn't work, when I run it on a core file I get:
>
> ...
> warning: couldn't find general purpose registers in core file.
> warning: wrong size fpregset struct in core file.
> ...
>
> And if I try to build gdb from scratch using
> "./configure --target=ppc-linux" I get a cross gdb that has no clue how to
> read PPC ELF core files.
>
> Help.
>
> -elan
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
