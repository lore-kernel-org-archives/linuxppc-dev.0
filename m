From: supas100@astrophysik.uni-kiel.de (Derek Homeier)
Message-Id: <199908301652.SAA13704@juliet.astrophysik.uni-kiel.de>
Subject: Re: Acclerated video driver on Powerbook G3 (lombard)
To: dnb0@gmx.net
Date: Mon, 30 Aug 1999 18:52:41 +0200 (MET DST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37C6E999.284BB6B@gmx.net> from "dnb0@gmx.net" at Aug 27, 99 07:40:29 pm
Reply-to: Derek Homeier <homeier@astrophysik.uni-kiel.de>
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


dnb0@gmx.net wrote:
> 
> the standard kernels fail to accelerate the ATI RAGE LT PRO on the
> lombard, but 
> the kernel modified by Paul Mackerras supports it well. you have to use
> rsync against
> samba.anu.edu.au/linux-pmac-stable to get it. the command should look like:
> 
> # rsync -arvz rsync://samba.anu.edu.au/linux-pmac-stable the-directiory-you-want-it
> (the r option may be obsolete, but i'm not shure)
> 
> you may point it to an existing source-tree, so rsync will only copy the diffs.
> 
Thanks, I'm going to try that out when I've set up a source tree, access
to samba.anu.edu.au is quite slow from up here.
Do you know if this one also contains the ethernet and/or USB patches?

Greetings,
							Derek

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
