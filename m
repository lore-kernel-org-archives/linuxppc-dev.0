Message-ID: <XFMail.990114104343.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <369D7A76.1FF003@cs.adelaide.edu.au>
Date: Thu, 14 Jan 1999 10:43:43 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Duncan Grove <duncan@cs.adelaide.edu.au>
Subject: RE: modify /usr/include/signum.h
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 14-Jan-99 Duncan Grove wrote:
> 
> someone needs to add #define SIGCLD    SIGCHLD to /usr/include/signum.h
> 
> btw, why are so many of the /include/*.h files (esp. tcp code) so
> screwed? -- Why/how were they messed up for the PPC release from the
> original Redhat 5.2 distribution?
> 

Mostly because they didn't come from the RedHat 5.2 distribution!
The majority of the ".h" files are part of the GLIBC package which
is now more than two years old.

This will be cleaned up, once the new GLIBC-2.1.xx packages are ready.

BTW - What do you mean "screwed" except for the plethora of warnings?

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
