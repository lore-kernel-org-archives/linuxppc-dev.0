Date: Sat, 5 Jun 1999 12:00:34 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
Reply-To: Brad Midgley <brad@turbolinux.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac-on-linux is now working...
In-Reply-To: <19990603200523.030085@mail.mipsys.com>
Message-ID: <Pine.LNX.3.95.990605112727.6609B-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


sorry i'm filling you mailbox :)

> >the virtual machine. i think i'll install a small macos on another drive
> >that has bootx and remove bootx from the main mac system. (it IS a trip to
> >watch linux boot inside linux however :)
> 
> I think I'll have to fix that...

is there a way bootx could tell it was running inside a mol session?

> Probably something in the adb emulation. I have some plans in mind to add
> better support in the kernel for routing directly ADB datas to MOL.
> Currently, MOL reconsitutes ADB datas from the Xpmac pseudo-keycodes send
> by the kernel to the front VC.

interesting approach. the xpmac code in the kernel could be fixed to deal
with multiple mice better (i'll have a look). /dev/adbmouse does deal
correctly with multiple mice--did you ever think of translating busmouse
info into an adb stream?

Brad
brad@pht.com | http://www.pht.com/~brad/




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
