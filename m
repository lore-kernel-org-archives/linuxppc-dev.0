Message-ID: <3B674558.1020908@mvista.com>
Date: Tue, 31 Jul 2001 16:55:04 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'Dan Malek'" <dan@mvista.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: New Linux PowerPC development
References: <A109131318C4D1119AC20060088DECE35732E9@mail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cindy Peters wrote:

 > We have just recently been instructed by management to stay with the
 >  MPC823 in order to re-use the previous software and hardware
 > development as much as possible. We are looking at using some VHDL
 > IP provided by Open Cores (this is very new) for the IDE interface.
 >  Are you familiar with this?
 >
 > The VHDL code uses a processor independent interface called a
 > wishbone interface. I don't know much about it yet. I don't know if
 >  this is something standard or just developed for Open Cores. Do
 > you (or anyone else) know of any driver software that may be
 > available for this interface?
 >

Having done several non-standard IDE interfaces before, I can say PIO
mode for the IDE OpenCore would be straight forward to implement. DMA is
always a bit more complicated.  I took a quick look thru the OpenCore
documentation.  It looks like the core would work on the 8xx bus with
few modifications.


 > I have downloaded the lmbench software to determine some benchmarking
information. I am not sure how to build it for the PPC. I have a cross
 > compiler development environment setup in a subdirectory. Can someone
help
 > me with this?

Sure, download our Journeyman product for 8xx, it includes
cross-compilers and 8xx userland.  ftp://ftp.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
