Message-ID: <37DDBFBF.FF1DF439@ctam.com.au>
Date: Tue, 14 Sep 1999 13:23:43 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx-2.3.10 directory structure
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I downloaded the mpc8xx-2.3.10 archive last night.  I was happy with the
configuration changes for 8xx targets though I will need to add and
Ethernet on SCC3 for our board.

I noticed that all the 860 board variants MBX, RPX and BSE are all
contained within the mbxboot directory tree.  This makes it easy to
maintain if the bootload stuff is very similar.  I was hoping to keep my
stuff speperated as much as possible from the mbxboot directory.  I
guess I am reasonably happy with this directory structure if the name
mbxboot was changed to something more generic (maybe 8xxboot or
boot8xx).

I can't remember which file it was now (embed_config.c I think) which
has bse_cfg(), rpx_cfg() etc.  I would have thought it would make sense
to split board specific stuff into there own files.  Each new board
would have it's own file for the board specific functions.

For now I'll just hack away in the mbxboot directory and try not to
create any files just to make the configuration and build process
easier.  I'll probably seperate my stuff to a different file at a later
stage and move all the stuff out of the mbxboot directory to our own
directory if need be.

Any comments on the directory structure for 8xx stuff ?

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
