Date: Wed, 5 May 1999 15:55:50 -0500 (CDT)
From: Derek Moeller <moeller@networksplus.net>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC 
In-Reply-To: <199905050555.WAA23579@soda.CSUA.Berkeley.EDU>
Message-ID: <Pine.LNX.3.96.990505155350.456A-100000@ns1.networksplus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 May 1999, Sriranga Veeraraghavan wrote:

> 
> 
> > Er, SMP uusbd?  uusbd currently doesn't have all the locking requires for
> > SMP to work. Linus' simple USB code might work on SMP, but doens't have an
> > OHCI driver that works yet.
>  
> I tried to make some simple patches to the uusb code to support
> locking using the same locking strategy as the vmscan.c and other
> kernel files, but there were too many things to fix.
> 
> Where can I pick up a copy of Linus's USB driver? It does not seem to
> be included with my 2.2.5 kernel sources.
> 

2.2.7 standard kernel. Beware, though, you can't even enable it by
default. If I were you, I'd wait for 2.2.8. Additionally, the current
drivers are *very* experimental from what I hear, and there's little
guarantee it would work with your mouse for the current release.

--

+----------------------------------------+
| Derek Moeller moeller@networksplus.net |
|     Linux for PowerPC User, Student    |
|   http://www.networksplus.net/moeller	 |
|	*	   *		*	 |
|    "aut inveniam viam aut faciam"	 |
+----------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
