Message-ID: <3814DCF8.D74828C0@netx4.com>
Date: Mon, 25 Oct 1999 18:43:04 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Still not booting
References: <Pine.LNX.4.10.9910251825040.434-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille wrote:


> ..... Right now, I find that the first
> access to the memory to clear it ends up in hanging the system. The
> address is 3004ddcc which obviously seems to be a logical or virtual
> address.


What are you using for the addresses of the IMMR, control registers
and such?  You can't use the default values that most debuggers
stuff into a FADS board, these have to all be moved into the
kernel virtual address space, which map 1:1 to their
corresponding physical address, and requires properly programming
the memory controller and changing the debugger scripts.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
