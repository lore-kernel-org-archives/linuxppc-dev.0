Date: Thu, 4 Feb 1999 22:33:12 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
cc: Geert.Uytterhoeven@cs.kuleuven.ac.be
Subject: modes "default" unfit for general use?
In-Reply-To: <199902042359.KAA10627@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990204221925.4095A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi...

Is it a mistake to have a distribution ship with modes "default" in the
default x windows configuration? 

> These days I use video=atyfb:vmode:17 and the XF86Config below

I was trying to use modes "default" on this iMac. Paul was using concrete
graphics modes. That made all the difference in getting a usable screen. 
This brings to light a general problem: is modes "default" being supported
by any developers? 

 1- It doesn't work with virtual screen sizes (modes "default" on imac
results in a 1024x6128--yes, six thousand--virtual screen size and the x
server ignores attempts to set the virtual screen size in XF86Config) 

 2- It appears that some video drivers just don't support modes "default"
eg iMac. The result on this machine is a white screen flecked with
artifacts and a mouse that appears and disappears, leaving a trail behind
it.

so... if we abandon modes default, what modeline generators are out there
that take the output of `fbset -x` and output a complete XF86Config? is
there a safe way to cycle through all the supported vmodes automatically
and capture these settings for several resolutions? 

brad



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
