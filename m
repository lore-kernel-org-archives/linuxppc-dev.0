Message-ID: <B0001827320@icamail.ica.net>
Subject: Re: [LinuxPPC] cross compiler, compiling 
Date: Sun, 28 Mar 99 13:03:44 -0400
From: Trevor Woerner <twoerner@ica.net>
To: "David Edelsohn" <dje@watson.ibm.com>
cc: "Users LinuxPPC" <linuxppc-user@lists.linuxppc.org>,
        "Developer LinuxPPC" <linuxppc-dev@lists.linuxppc.org>,
        "Fred Fish" <fnf@cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>	Without describing the directory structure for the cross-tools
>source and how it was configured, it is hard to diagnose what might be
>wrong.

would it be enough to say:

  target=powerpc-linux
  prefix=/usr/local/ppc
  includes=/usr/local/ppc/linuxppc-includes/
  libraries=/usr/local/ppc/linuxppc-lib
  cpu=603e

  root# ../egcs-1.1.1/configure --target=$target --prefix=$prefix \
        --enable-shared --enable-haifa --with-gnu-as --with-gnu-ld \
        --with-headers=$includes --with-libs=$libraries --with-newlib \
        --with-cpu=$cpu -v &> configure.log

for the includes i went to my LinuxPPC installation and took everything
from /usr/includes, resolved all links and removed obvious stuff like
X11, for the libs i took everything from /lib and /usr/lib, resolved
all references (which were almost always from /usr/lib to /lib) but
preserved the shared-library version links.

does that help? oh by the way my LinuxPPC kernel was compiled from the
Linux 2.2.1 sources. previous to doing this i had recompiled egcs 1.1.1
and binutils 2.9.1-19b on my x86; on the ppc i just installed the rpms
from Gary Thomas.

please don't hesitate to mention if i forgot anything else.

best regards,
   trevor woerner

------------------------------------------------------------

...Senior, for his first selection, will play "A Cup Of
   Coffee, A Sandwich, And You" from the opera: Aida

                             --- Groucho Marx
                                 The Cocoanuts, 1929


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
