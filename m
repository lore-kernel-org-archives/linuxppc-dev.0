Message-ID: <384B1202.F4BEF0D0@netx4.com>
Date: Sun, 05 Dec 1999 20:31:46 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Peter Brown <pfb@syseng.anu.edu.au>
CC: Ole.Reinartz@nokia.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Math Emulation again
References: <A914533BF4B9D2118D980008C7894C0A014D54F0@dueis01nok> <384AFB2B.715EECB6@syseng.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Brown wrote:


> Has anyone tried writing a driver for the MPC860 CPM DSP?


The actual interface isn't any different than other devices.
Just allocate some buffer descriptors and go for it.


> .....  The Motorola FAQ
> says that it can perform an 8x8 pixel Discrete Cosine Transform in 30uS (@
> 25Mhz clock speed).


Yes, and Motorola has a version of this for selected customers.

> ....  The MPC823 has a DSP coprocessor in it as well.  The
> MPC860 DSP library is targeted for modem processing but could be used for
> other purposes.


Motorola also has a version of the soft modem.  I don't know
the status of that.

Just to clarify this a little.  The CPM has a MAC (multiply-accumulate)
piece of hardware available.  The 'DSP' is a few functions written
in CPM microcode that use the MAC to provide DSP-like features.
There is no DSP in the processor.  The soft modem is CPM
microcode that uses the MAC and some of the DSP functions internally.

Writing CPM microcode is not available to anyone for general
purpose use.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
