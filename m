Message-ID: <376FFF26.A7493FF1@americasm01.nt.com>
Date: Tue, 22 Jun 1999 17:24:54 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: puetzk6715@uni.edu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppp compression module aliases?
References: <Pine.PMDF.3.96.990622120549.539020675E-100000@uni.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


puetzk6715@uni.edu wrote:
> 
> The easiest way to get all this stuff right is
> 
> modprobe -c > /etc/conf.modules
> 
> the -c argument causes modprobe to print a complete conf.modules (less any
> strange stuff specific to your machine), so I just redirect it to the
> file. The installer should do this, though...
> 
> Hmm... or did you mean modprobe left these out of its generated file when
> you said 'modprobe doesn't know these aliases'. It only (as far as I know)

Yes.  modprobe -c doesn't include ppp-compress aliases, at least my
version doesn't have them.


> 
> On Sun, 20 Jun 1999, Jerry Quinn wrote:
> 
> >
> > I have a question that I'm not sure is best directed to kernel people or
> > user-space people as it crosses the line.
> >
> > After a bunch of time trying to figure out why the ppp compression
> > modules weren't getting loaded automatically, I traced it the fact that
> > the appropriate aliases are not present in /etc/conf.modules.
> >
> > In particular, the following aliases are required:
> >
> > ppp-compress-21       = bsd-compress
> > ppp-compress-24 = ppp-deflate
> > ppp-compress-26 = ppp-deflate
> >


-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
