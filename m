Message-ID: <39085EE9.6052CE60@embeddededge.com>
Date: Thu, 27 Apr 2000 11:38:17 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Subject: Re: MPC860T
References: <0FTO0083YCJPTE@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:

> After some success with the native 860, I moved now to the 860T
> on the FADS evaluation board.

You poor soul.....


> 2. I'm not able to compile the kernel with only FEC enabled.
>  (commproc.h reports: #error, undefined config!)

That's interesting.  What kernel are you using?

> 3. Is it possible to use SCC1 enet and FEC simultaneously.

Of course.  I use it as a firewall/gateway/router.....

> Can someone provide patches or howto's?

Get the 2.2.13 kernel from MontaVista's ftp site.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
