Message-ID: <38554E45.7DA8598A@netx4.com>
Date: Mon, 13 Dec 1999 14:51:33 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Noah Misch <nmisch@erols.com>
CC: Grant Erickson <grant@lcse.umn.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC Cache Flush and Invalidate Routines
References: <384EF3D1.DFC1D281@jlc.net> <v04011700b479adc20511@[216.164.138.53]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Noah Misch wrote:

> Instead of stuff like this:
> 
> #ifdef CONFIG_403
> ...
> #endif
> 
> you could write the code like this:
> 
> if(CONFIG_403) {
> ...
> }


Except that most of the code under discussion is written
in assembly language.......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
