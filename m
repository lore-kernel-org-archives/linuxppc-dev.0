Message-ID: <391329A0.763DED8@embeddededge.com>
Date: Fri, 05 May 2000 16:05:52 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: jlquinn@us.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with cross-endian bitfields?
References: <852568D6.006ADE94.00@D51MTA03.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


jlquinn@us.ibm.com wrote:

> Hi, all.  I'm working on getting the Advansys driver working and what
> appears to be the final stumbling block is a difference in the layout of
> bitfields between little-endian and big-endian systems.

IMHO, bit fields are not normally a good thing to be using if this is
describing a real device register.  The compiler is able to read/write
in ways that may not be proper for hardware access.  For device registers
and when this is a data structure in memory, the cross-platform method
of using macros for reading writing 16- and 32-bit values and then 'C'
operators for testing/setting bits has worked pretty well in the past.....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
