Date: Mon, 26 Apr 1999 17:38:03 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: Takashi Oe <toe@unlinfo.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pty problem in RawHide
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990426141922.431A-100000@selq119.unl.edu>
Message-ID: <Pine.LNX.3.96.990426170244.16979B-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Apr 1999, Takashi Oe wrote:

> On Mon, 26 Apr 1999, Kevin Hendrickson wrote:
> 
> > having ALL services commented out by default (why?) Anyway now I get
> > "telnetd: All network ports in use"! Even when telneting to 127.0.0.1 from
> > the console. Also attempts to run xterm fail with "xterm: no available
> > ptys"! 
> 
> I don't really know the root of the problems you are experiencing, but I 
> have seen something similar when I first tried rawhide.
> 
> Do you have UNIX98 PTY support and devpts filesystem support enabled in
> your kernel?  If so, do you have /dev/pts mounted properly?  My problems
> went away when I added an entry for /dev/pts in /etc/fstab and did "mount
> /dev/pts".  I think Documentation/devices.txt has some infos on it.

Thanks! That was it. I checked Documentation/Changes which had a bit more
info than devices.txt on setting up /etc/fstab and mounted /dev/pts. Works
like a charm.

Now I have to figure out why the keys seem to be screwed up in Gnome. 
When in the console, all is well, but whenever I type in an X app like
xterm, the keys are all screwed up. 

Kevin

*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
