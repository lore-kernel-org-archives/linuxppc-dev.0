Message-ID: <3A898030.820F2B3D@mvista.com>
Date: Tue, 13 Feb 2001 10:42:56 -0800
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Grant Erickson <erick205@umn.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for Soft-Float Problems w/ Glibc & Gcc?
References: <Pine.SOL.4.20.0102131051470.8375-100000@garnet.tc.umn.edu> <3A897356.3DAB1D3@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> Grant,
>
> As I understand it, Softfloat does NOT produce software emulation.
> One must have a library to which to link inorder to floating point in
> this situation.
>
> The MontaVista toolset seems to have the floating point emulation in it.

Actually thats only partially true.. the floating point "library" is
internal to gcc on PowerPC processors.. and on all of the processors
that MontaVista supports.

gcc/config/fp-bit.c is the file included with gcc to support
soft-floating point.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
