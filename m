Date: Fri, 5 May 2000 16:45:19 -0400
From: Josh Huber <huberj@wpi.edu>
To: jlquinn@us.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with cross-endian bitfields?
Message-ID: <20000505164519.A1643@mclinux.com>
References: <852568D6.006ADE94.00@D51MTA03.pok.ibm.com> <391329A0.763DED8@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <391329A0.763DED8@embeddededge.com>; from dan@netx4.com on Fri, May 05, 2000 at 04:05:52PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 05, 2000 at 04:05:52PM -0400, Dan Malek wrote:
> IMHO, bit fields are not normally a good thing to be using if this is
> describing a real device register.  The compiler is able to read/write
> in ways that may not be proper for hardware access.  For device registers
> and when this is a data structure in memory, the cross-platform method
> of using macros for reading writing 16- and 32-bit values and then 'C'
> operators for testing/setting bits has worked pretty well in the past.....
Yeah, I just looked in the PowerPC ABI for bitfield storage, and the
relevant text said:
* Bit-fields are allocated from right to left (least to most significant) on
Little-Endian implementations and from left to right (most to least
significant) on Big-Endian implementations.

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
