Date: Mon, 19 Jul 1999 16:22:53 +1000
Message-Id: <199907190622.QAA03535@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: gargus@cs.ualberta.ca
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <99070500554905.22100@24.65.216.209.ab.wave.home.com> (message
	from Joshua Gargus on Mon, 5 Jul 1999 00:44:58 -0600)
Subject: Re: DMA sound compatability with OSS API
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <99070500554905.22100@24.65.216.209.ab.wave.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joshua Gargus <gargus@cs.ualberta.ca> wrote:

> I'm trying to compile an application (the virtual machine for Squeak 
> Smalltalk) that requires several ioctl() calls defined in 'soundcard.h', 
> including 'SNDCTL_DSP_GETCAPS' and 'SNDCTL_DSP_GETOSPACE'.
> These are not defined in 'drivers/sounds/dmasound.c', although the 
> comment at the top of the file declares it to be 'OSS compatable'.
> 
> I don't know too much about this stuff at all.  Is there some reason that
> the Macintosh sound hardware cannot support these calls, or have they
> just not been implemented yet?  Is adding support for these calls in the
> works, or is it an itch I'll have to scratch for myself?

Basically they just haven't been implemented yet.  I don't know if
anyone is actively working on doing them at present.  They shouldn't
be too hard to implement.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
