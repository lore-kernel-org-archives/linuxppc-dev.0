Message-ID: <3959368C.218AB605@netx4.com>
Date: Tue, 27 Jun 2000 19:19:40 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Matt Gessner <mattg@aiinet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260, FCC and local bus
References: <3958BBF1.20E543AB@aiinet.com> <39590837.29E8FE30@aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Gessner wrote:

> I had ioremap'd it, and put va's and pa's where each belonged
> (va's for the kernel's tracking stuff and pa's for the CPM stuff).


The va/pa macros are not going to work on Local memory addresses.
You have to explicitly compute these addresses.

I have a board with some local memory.  I'll test it.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
