Message-Id: <v03110700b3ccb99d1eda@[209.183.129.41]>
In-Reply-To: <37A69135.B128D704@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 3 Aug 1999 11:25:06 -0400
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Can I use usb mouse with Xpmac server?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I want to use the Xpmac server on my B+W G3 running Paul's 2.2.10 kernel.

I can startx fine with Xpmac and it sees the usb keyboard fine, but I can't
make it see or use the usbmouse.

I tried symbolically linking usbmouse to mouse in /dev to no avail.

I did try borrowing an adb mouse and plugging it into the adb port on the
B+W and it works fine (usb keyboard with adb mouse).

Any tricks here?  Can I somehow change the /dev/ mouse entries and get
Xpmac server to work.

Thanks,

Kevin



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
