Message-ID: <3789A959.88F0729@pop.agri.ch>
Date: Mon, 12 Jul 1999 10:37:48 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: media bay problems
References: <199907112302.JAA20812@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just built and tested, works fine for me on PBG3 Wallstreet 250.

Thanks
Andreas

Paul Mackerras wrote:
> 
> The fix for the media bay problems is to change in_8 to inb in the
> definition of MB_IDE_READY in mediabay.c.  I am away from home at the
> moment, that's why I haven't posted a patch. :-)
> 
> Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
