Date: Tue, 22 Jun 1999 12:08:54 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: ppp compression module aliases?
In-reply-to: <376D4EDC.4983826B@americasm01.nt.com>
To: Jerry Quinn <jquinn@nortelnetworks.COM>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990622120549.539020675E-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The easiest way to get all this stuff right is 

modprobe -c > /etc/conf.modules

the -c argument causes modprobe to print a complete conf.modules (less any
strange stuff specific to your machine), so I just redirect it to the
file. The installer should do this, though...

Hmm... or did you mean modprobe left these out of its generated file when
you said 'modprobe doesn't know these aliases'. It only (as far as I know)
follows directives in the file, not other ones it knows.

On Sun, 20 Jun 1999, Jerry Quinn wrote:

> 
> I have a question that I'm not sure is best directed to kernel people or
> user-space people as it crosses the line.
> 
> After a bunch of time trying to figure out why the ppp compression
> modules weren't getting loaded automatically, I traced it the fact that
> the appropriate aliases are not present in /etc/conf.modules.
> 
> In particular, the following aliases are required:
> 
> ppp-compress-21	= bsd-compress
> ppp-compress-24 = ppp-deflate
> ppp-compress-26 = ppp-deflate
> 
> I vaguely remember seeing this advice once in the past which I promptly
> forgot.  So now I'd like to save others the headache and make sure this
> get set up right.
> 
> The current situation is as follows: 
> 
> * modprobe 2.1.121 (which is apparently still the current version for R5
> as of may 23 - I haven't reupdated) doesn't know these aliases


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
