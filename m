Date: Tue, 4 May 1999 20:05:49 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC
In-Reply-To: <199905042220.PAA17423@soda.CSUA.Berkeley.EDU>
Message-ID: <Pine.LNX.4.05.9905042004520.667-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 May 1999, Sriranga Veeraraghavan wrote:

> If anyone has been able to comple the uusb driver on LinuxPPC, I would
> appreciate some pointers.  Also if there is a version of the usb
> drivers that compiles with kernel 2.2.0pre6, I would like to use it,
> since the SMP support on 2.2.1+ has been quite buggy for me.

Er, SMP uusbd?  uusbd currently doesn't have all the locking requires for
SMP to work. Linus' simple USB code might work on SMP, but doens't have an
OHCI driver that works yet.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
