To: Jeff Rugen <jrugen@primenet.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Linux Framebuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Xbh X server/adding acceleration to XF68_FBDev
References: <Pine.BSI.3.96.990316204520.10665A-100000@usr01.primenet.com>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 17 Mar 1999 10:43:59 +0100
In-Reply-To: Jeff Rugen's message of "Tue, 16 Mar 1999 20:52:44 -0700 (MST)"
Message-ID: <d3oglscuxs.fsf@valhall.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Jeff" == Jeff Rugen <jrugen@primenet.com> writes:

Jeff> Now, the reason I included the Framebuffer list is I was
Jeff> interested in adding acceleration for the clgen framebuffer in
Jeff> the XF68_FBDev server.  What source should I use as a starting
Jeff> point?  (I have the 3.3.3 server-only source right now).  I'll
Jeff> also use that as an excuse to verify that 32-bit modes really
Jeff> work with clgenfb.  Thanks.

Use the Cirrus Logic accel code from the SVGA server, basically the
long term goal is to merge the FBDev and SVGA servers.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
