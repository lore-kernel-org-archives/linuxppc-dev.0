Message-ID: <374B35B4.F477CA84@dgs.monash.edu.au>
Date: Tue, 25 May 1999 23:43:48 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: egcs mailing list <egcs@egcs.cygnus.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Cross-GCC <crossgcc@cygnus.com>
Subject: Re: can't find crt1.o. egcs powerpc-linux cross-compile problem.
References: <9905251517.AA44940@marc.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:

>         Did you build cross-binutils at the same time as cross-gcc?
>
> David

Nope.  I built binutils seperately and installed them.  I then added the
install path to my PATH environment variable and then started to build
egcs.  I was following the LinuxPPC cross-compiler instructions and have
done this for a powerpc-eabi cross-compiler.  The only difference was
that I left out the --with-newlib option to configure.  Having read
other replies, this option MIGHT solve my problem.  The LinuxPPC
instructions for building a cross-compiler say that the --with-newlib
option is there to avoid linking in __eprintf.  I know that Linux now
uses glibc and was a bit worried about using the --with-newlib switch in
case it stuffed things up later.  I couldn't find any references to
linux in the newlib source (which is sort of what I expected) so I
thought that I did not need use the --with-newlib option.

Can anyone advise me on the best approach ?

Thanks,
Brendan Simon.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
