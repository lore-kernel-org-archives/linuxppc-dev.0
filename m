Date: Tue, 26 Oct 1999 14:52:55 -0700 (PDT)
Message-Id: <199910262152.OAA02956@sade.ddi.com>
From: Jim Terman <terman@ddi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Kumar Gala <kumar@chaos.ph.utexas.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <Pine.LNX.4.10.9910252336320.2381-100000@chaos.ph.utexas.edu>
References: <199910252051.NAA07105@sade.ddi.com>
	<Pine.LNX.4.10.9910252336320.2381-100000@chaos.ph.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Will the linuxppc kernal as it is right now save the AltiVec registers
if we enable the MSR VEC bit.  I've been trying to follow the other messages
on this subject, but I'm not clear.

Kumar Gala writes:
> 
> The linux kernel as is will not effect the AltiVec registers in any way.
> However, there is a minor change to the kernel that will be required.  You
> will need to enable the MSR VEC bit (bit 6 in the MSR) to tell the
> processor that the AltiVec Unit is available (this is similar to the MSR
> FP bit).  If the bit is not set the processor will generate an AltIVec
> Unavailable exception which will be trapped (incorrectly) as an unknown
> 0xf00 exception
> 
> the 0xf00 exception is for the performance monitors
> and 0xf20 in the AltiVec unavailable exception.
> 
> All if these details are documented in the AltiVec Programming Environ
> Manual (available from the Motorola Website).  
> 
> If you need any help getting a simple kernel up and running for running
> single altiVec enabled processes let me know.
> 
> - kumar gala
> 
> 
> ignorance is bliss.
> 
> 
> 
-- 
______________________________________________________________________________
Jim Terman       |   323 Vintage Park Dr.   |   Voice: (650) 356-5446
terman@ddi.com   |   Foster City, CA        |   Fax:   (650) 356-5490
Diab-SDS, Inc.   |   94404                  |   web site - http://www.ddi.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
