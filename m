Date: Mon, 21 Jun 1999 14:33:37 +1000
Message-Id: <199906210433.OAA00562@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: precompiled kernel location
Reply-to: Paul.Mackerras@cs.anu.edu.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Someone pointed out that dev.linuxppc.org doesn't have my stuff.  I
can't get into ftp.linuxppc.org to put my stuff there.  Instead it is
available at this location:

ftp://sunsite.anu.edu.au/pub/linux/linux-pmac/

I have had a couple of emails to say that the kernel works on the blue
& white G3.  The thing I forgot to mention is that if you are using X
(i.e. XF68_FBDev) with a USB mouse, you need to edit your XF86Config
to set the mouse protocol to "IMPS/2".  Also, the USB keyboard/mouse
drivers don't yet provide a way to emulate the 2nd and 3rd mouse
buttons using keys on the keyboard.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
