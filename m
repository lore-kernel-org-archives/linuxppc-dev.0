Message-ID: <37164E34.9B29EDBE@jlc.net>
Date: Thu, 15 Apr 1999 16:38:12 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Embedded 8xx 2.2.5 kernel tarball
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To all of you that have been asking lately........

I have finally uploaded the tar image of the directory I am using for the
8xx updates.  I have not checked in all of these changes to CVS as I
still have to do my best to ensure I have not broken something.

Some of you have indicated you wish to contribute modifications, so please
implement them against this source base and send me the patches or files.

When you use this kernel, I would appreciate hearing of success as well
as failure.

For those of you that use the embedded system as I do (single user shell),
I have added the 'standalone shell' that creates a new thread for starting
the shell.  This enables proper signal handling so tty control signals work.
I don't know if this will boot to multi-user properly, so if you do not want
this behavior go into init/main.c and undefine SASH.

The tar file is on linuxppc.cs.nmt.edu in the embedded directory, called
embedded-2.2.5.tgz.

Have fun.

    -- Dan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
