Date: Sat, 31 Jul 1999 15:12:24 -0500 (CDT)
From: Vinai <vroopcha@post.its.mcw.edu>
Reply-To: Vinai <vroopcha@post.its.mcw.edu>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
In-Reply-To: <19990801005311S.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.SOL.3.96.990731150035.5467A-100000@post.its.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Aug 1999, Ryuichi Oikawa wrote:

}I'm trying to implement C&T 6555x HW acceleration to the X servers.
}I put a Xpmac binary:
} ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/powermac/Xpmac-
}19990731-glibc2.1.gz
}XF68_FBDev version hasn't been compiled, yet.
}
}Because I don't have any C&T 6555x hardware, I need testers for
}debugging.  Thank you for your help.

Hi,

I grabbed your Xpmac binary this morning and tried it out on a 3400/240
running R5.  It seemed to work well for the most part.  Very noticeable
acceleration, especailly over the XF86 server I was currently using.  I
did run into a couple problems though.

- If windows are moved around too quickly, vertical bands appear.  If I
  explicitly request that part of the screen to be redrawn (e.g. by my
  closing the xterm and reopening it), the lines disappear.

- When I passed it the wrong option (I used "startx --depth 16" instead
  of the correct "startx -- -depth 16", it off course ignored the wrong
  swtich and started up in 8-bit colour).  But on exiting X, it locked
  up the machine completely.  I couldn't even switch to another virtual
  console to kill the process or reboot the machine, so I ended up with
  a hard reboot).  For a window managers - I am using an old version of
  AfterStep that I recompiled from the src.rpm for R5.  It is version
  1.0.7a (Yes - I know it's old, but it is small, I know how to set it
  up, and does all I need ;-)

Otherwise, I have not found any other problems, and the person that uses
this machine is actually pretty happy right now, as am I ;-)  Thanks for
the great work !!

cheers
vinai




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
