Message-ID: <3A81F8C9.21DD6C8A@mvista.com>
Date: Wed, 07 Feb 2001 17:39:21 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Dan Malek <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A6CCBDC.3D7B722A@mvista.com>
		<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
		<14975.55035.835724.234984@tango.linuxcare.com.au>
		<3A806D89.16B31EA0@mvista.com>
		<14976.30150.97137.755604@tango.linuxcare.com.au>
		<3A808560.6FF96E3C@mvista.com>
		<14976.38302.725479.486320@diego.linuxcare.com.au>
		<3A818DAE.3182B163@mvista.com> <14977.60657.871016.955014@diego.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> I think that it is seductive but misleading when the PPC docs say that
> the PPC supports a "large virtual address space".  Yes it does, in a
> sense, but it's not one that you can access directly on a 32-bit PPC;
> you have to go changing segment registers to get at all of it - i.e.,
> there's no such thing as a pointer into this space that the CPU
> understands natively.  You could have such a pointer as a 64-bit
> value, but to use it you have to split it apart and put one part in a
> segment register and make a pointer that the CPU understands out of
> the other part.  And the other thing is that there just aren't enough
> segment registers on 32-bit PPCs to be really useful (except as a way
> of coarsely partitioning the address space).

Then there are the PPC processors that don't even have segment registers....

> Paul.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
