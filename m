Date: Tue, 3 Aug 1999 18:51:34 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>
cc: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can I use usb mouse with Xpmac server?
In-Reply-To: <v03110700b3ccb99d1eda@[209.183.129.41]>
Message-ID: <Pine.LNX.4.10.9908031830280.20406-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



 I don't think that Xpmac can use the usb mouse at all, from what i am told
its getting the mouse events through the keyboard, take a look in
mouse_input() at linux/drivers/macintosh/mac_keyb.c to see the ugly thing
in all its glory. 

  Kostas Gewrgiou

PS> this have to go at some point since its everything that maps the keyboard
at RAW gets lots of garbage.

On Tue, 3 Aug 1999, Kevin B. Hendricks wrote:

> 
> Hi,
> 
> I want to use the Xpmac server on my B+W G3 running Paul's 2.2.10 kernel.
> 
> I can startx fine with Xpmac and it sees the usb keyboard fine, but I can't
> make it see or use the usbmouse.
> 
> I tried symbolically linking usbmouse to mouse in /dev to no avail.
> 
> I did try borrowing an adb mouse and plugging it into the adb port on the
> B+W and it works fine (usb keyboard with adb mouse).
> 
> Any tricks here?  Can I somehow change the /dev/ mouse entries and get
> Xpmac server to work.
> 
> Thanks,
> 
> Kevin
> 
> 
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
