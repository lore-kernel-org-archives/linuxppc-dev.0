Date: Wed, 28 Jul 1999 11:46:35 +1000
Message-Id: <199907280146.LAA01847@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bob@jriver.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <379D203D.FAAA971@jriver.com> (message from Robert Brose on Mon,
	26 Jul 1999 21:58:05 -0500)
Subject: Re: usb mouse in 2.2.10
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <379D203D.FAAA971@jriver.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert Brose <bob@jriver.com> wrote:

> 1) The keyboard response is somewhat odd. If I type "cd /anything" at the
> prompt, it fairly
> regularly does cdcd /anything on the echo. It's hard to pin down because it

This is a problem in the USB keyboard driver, where it doesn't handle
the `key rollover error' keycode correctly.  The iMac keyboard gives
this keycode if you press more than 2 keys (other than modifiers) at
once.

> If I cat /dev/mouse and move it I get moving lines of junk as I would expect.
> The bus mouse
> protocol looks suspicious but it works in 2.2.5 and I haven't found anything to
> replace it with
> yet.

Use "IMPS/2" (or "imps2" for gpm).

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
