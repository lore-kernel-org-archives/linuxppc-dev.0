Date: Sat, 15 May 1999 10:04:56 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: blokos <blokos@worldnet.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: maccoach and linux ppc
In-Reply-To: <373CD376.7B669411@worldnet.fr>
Message-ID: <Pine.LNX.4.05.9905151002430.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(Didn't see the orig email, sorry).

On Sat, 15 May 1999, blokos wrote:

> Support wrote:
> 
> > Maccoach is a great product that permit your server to reboot
> > automatically when it crashes... but it works only with Mac os. So i
> > ve sent an email to Maccoach support and that is the answer

This sounds exactly like the software watchdog config option:
CONFIG_SOFT_WATCHDOG:

  A software monitoring watchdog. This will fail to reboot your system
  from some situations that the hardware watchdog will recover
  from. Equally it's a lot cheaper to install. 

This should work on ppcs.  If you need a HW solution, the watchdog PCI
cards should work (the ones w/ drivers that is), but you never know.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
