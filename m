Date: Tue, 13 Jul 1999 22:09:16 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Frame buffer on B+W G3 macs reports wrong display depth
In-Reply-To: <v03110700b3b1a7635364@[209.183.132.89]>
Message-ID: <Pine.A41.3.96LJ1.1b7.990713220013.49756A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Jul 1999, Kevin B. Hendricks wrote:

> Hi,
> 
> I really could use some help tracking down a problem.  From looking at
> XF86Config and from running xdpyinfo, it seems the XF86 frame buffer server
> reports incorrect bit depths which in turn are driving the JDK 1.2 swing
> color model crazy!!!
> 
> For example, when I put my B+W into millions of color mode, xdpyinfo claims
> 32 bits for the depth (wrong it is 24, 8 bits for red, green, and blue),
> and correctly claims 32 bits per pixel.

Can you re-code JDK swing to look at red/green/blue mask infos instead of 
just blindingly using "depth" info?  For both servers, masks are 8 bit
each for 24/32 and 5 bit each for 15/16 with many display cards on Macs.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
