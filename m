From: "Robert E. Brose II" <bob@jriver.com>
Message-Id: <199907282124.QAA06117@jriver.com>
Subject: Re: usb mouse in 2.2.10
In-Reply-To: <199907280146.LAA01847@tango.anu.edu.au> from Paul Mackerras at
	"Jul 28, 1999 11:46:35 am"
To: Paul.Mackerras@cs.anu.edu.au
Date: Wed, 28 Jul 1999 16:24:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Paul Mackerras says:
> Robert Brose <bob@jriver.com> wrote:
> 
> > 1) The keyboard response is somewhat odd. If I type "cd /anything" at the
> > prompt, it fairly
> > regularly does cdcd /anything on the echo. It's hard to pin down because it
> 
> This is a problem in the USB keyboard driver, where it doesn't handle
> the `key rollover error' keycode correctly.  The iMac keyboard gives
> this keycode if you press more than 2 keys (other than modifiers) at
> once.

Aha, I am definitely a N-Key rollover person!
 
> > If I cat /dev/mouse and move it I get moving lines of junk as I would expect.
> > The bus mouse
> > protocol looks suspicious but it works in 2.2.5 and I haven't found anything to
> > replace it with
> > yet.
> 
> Use "IMPS/2" (or "imps2" for gpm).

Works well but if I pick up a window and move it around quickly a lot I
can make the mouse cursor go bye-bye.

Bob

-- 
|   Robert E. Brose II         (N0QBJ)          | J. River, Inc.         |
|      WWW:   http://www.jriver.com/~bob/       | 125 North First Street |
|      EMAIL: mailto:bob@jriver.com             | Minneapolis, MN 55401  |
|                                               | 612-339-2521 x212      |


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
