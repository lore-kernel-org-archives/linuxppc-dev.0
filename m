Date: Mon, 26 Apr 1999 14:27:41 -0500 (CDT)
From: Takashi Oe <toe@unlinfo.unl.edu>
To: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pty problem in RawHide
In-Reply-To: <Pine.LNX.3.96.990426091814.16776A-100000@net178019.hcv.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990426141922.431A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Apr 1999, Kevin Hendrickson wrote:

> having ALL services commented out by default (why?) Anyway now I get
> "telnetd: All network ports in use"! Even when telneting to 127.0.0.1 from
> the console. Also attempts to run xterm fail with "xterm: no available
> ptys"! 

I don't really know the root of the problems you are experiencing, but I 
have seen something similar when I first tried rawhide.

Do you have UNIX98 PTY support and devpts filesystem support enabled in
your kernel?  If so, do you have /dev/pts mounted properly?  My problems
went away when I added an entry for /dev/pts in /etc/fstab and did "mount
/dev/pts".  I think Documentation/devices.txt has some infos on it.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
