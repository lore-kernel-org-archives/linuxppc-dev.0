Message-ID: <368E5AB5.F9E88390@pop.agri.ch>
Date: Sat, 02 Jan 1999 18:43:22 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        linux-pmac@samba.anu.edu.au
Subject: fd_set & pre 5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm sitting here for about five hours or more and I try to compile JX-1.1.18
from J. L. and others. I did the same job weeks before uner Linuxppc R4 with
success. Now I try it under pre -5 (version before X-mas 17.12.1998). Well, my
experiences are growing day by day but right now I feel lost in the forest. 
My irritations are about the different includes. Where does it come from?

My problem is: error message by the compiler (egcs from pre 5 1.1.1xy (don't
know)) struct fd_set has no member fdbits. ! I   have two machines running
linuxppc, a PBG3 W with R4 kernel 2.1.130 and a PM 7200/ 90 with pre 5 and
kernel 2.1.131. On the PB I can find a definition for the struct fb_set. I put
in the the definition of struct fb_set in posix_types.h on the 7200, no
success. 
Where can I get infos, hints about the different includes and places of the
necessary includes?

Thanks for every hint & a happy 99

Andreas

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
