Message-ID: <3742CF84.3A348038@americasm01.nt.com>
Date: Wed, 19 May 1999 10:49:40 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: OF booting news
References: <Pine.SUN.4.02.9905190926070.19636-100000@sea.ntplx.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Wed, 19 May 1999, Jerry Quinn wrote:
> 
> > Umm, any news about Platinum drivers?  Otherwise, a revised loader still
> > wouldn't be very useful on 7200 class machines.
> 
> There were many of patches in there.  I wasn't aware the 7200 OF was
> broken.  The source is the boot part of darwin, in SecondaryLoader, iirc.

I think the issue is that there isn't an OF driver at all for the
platinum controller.  With the old OF booting through quik, nothing
could display on the screen until linux took control, which was one
reason why BootX is a huge improvement (as is MkBooter for mklinux).

Unless I'm getting the issues wrong (always a possibility :-)

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
