Date: Wed, 23 Jun 1999 00:44:11 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Brad Midgley <brad@pht.com>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-users@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: precompiled 2.2.10 kernel available
In-Reply-To: <Pine.LNX.3.95.990622145132.8302A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.4.10.9906230017340.3553-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



We can use xkb to handle mouse clicks, the mousekeys option already handles
nouse movement/clicks, it might be a little hard to get used to but it will
do as a temporary solution. Now that i am thinking of it we can write something
similar (that will emulate only mouse buttons) and stop worrying about kernel
support.

Kostas Gewrgiou. 
 
On Tue, 22 Jun 1999, Brad Midgley wrote:

> 
> if the keyboard and mouse are going to be this way for good, i will patch
> xconfigurator so it does the right thing.
> 
> is there a way to get the middle- and right- mouse buttons via the
> imac keyboard or is that code missing from the linus-usb?
> 
> > > did the protocol of /dev/usbmouse have to change? :( now it appears as a
> > It was Linus' decision.  Argue with him. :-)
> > Use protocol "IMPS/2" in your XF86Config.
> > Paul.
> 
> Brad
> brad@pht.com | http://www.pht.com/~brad/
> 
> 

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
