Date: Sun, 4 Nov 2001 21:08:42 -0800 (PST)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: dmasound_pmac in 2_4_devel
Message-ID: <Pine.GSO.4.32.0111041903030.26186-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm doing work that requires sound input.  In order to use the built-in
microphone on my iMac (screamerawacs) I compiled the current 2_4_devel
source, which has Iain Sandoe's dmasound_pmac patches. There were several
issues I hope to resolve.

I found a very audible clicking and popping during audio playback.  This
is noticeable e.g. when playing normal MP3 files with xmms.  The clicking
does not occur with the driver in the (non-devel) 2_4 tree.  I also had
some programs lock up while playing sound.

There were some other sound problems I haven't tracked down yet.  Before I
continue working on this, I'd like to find out who is actively working on
the dmasound_pmac driver, and where I can get more information.  I'm
willing to work on the driver, but I'm new to the code and could use some
help getting started.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
