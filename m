Date: Wed, 6 Jan 1999 09:39:13 +1100
Message-Id: <199901052239.JAA04790@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: tas@mindspring.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <v04011700b2b76717bf6b@[209.86.156.101]> (tas@mindspring.com)
Subject: Re: Strange PMAC IDE performance problem
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v04011700b2b76717bf6b@[209.86.156.101]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy A. Seufert <tas@mindspring.com> wrote:

> Needless to say, the IDE performance figures are far less than those drives
> are capable of!  Under MacOS they benchmark much higher (for example, the
> 38451 scores 7780 to 9472 KB/s (8819 avg) sustained read on the FWB

I have noticed this poor performance myself but it's hard to say what
might be the cause - whether it's some bit that needs to be set
somewhere in a hardware register, or something about the IDE driver
that is causing it to waste time somewhere.  One way to start getting
some information would be to add some statements to the IDE driver to
read the timebase register to get some timing information about how
long different parts of the process take.  If it is that the hardware
is not transferring the bytes very fast, then we need to look for a
value in a hardware register which is different between macos and
linux.  I don't think I will be able to get on to it soon but if
someone else wants to have a go that would be great.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
