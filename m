Date: Thu, 30 Aug 2001 02:20:35 -0700 (PDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [dmasound] Power Computing DEAD dbdma fix (finally)
In-Reply-To: <20010727194525.345C0DBB0C@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.33.0108300215490.10298-100000@like.mine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you!  This does the job.  Any chance of getting this into the -benh
or Linus kernel?

Just to let you know how much I had to run my "killall xmms; rmmod
dmasound; insmod dmasound" script before your patch:

Aug 30 01:46:51 like kernel: dmasound_pmac: tx-irq: xfer died - patched it up...
Aug 30 01:50:15 like kernel: dmasound_pmac: tx-irq: xfer died - patched it up...
Aug 30 01:51:19 like last message repeated 4 times
Aug 30 01:52:29 like last message repeated 2 times
Aug 30 02:05:01 like last message repeated 2 times
Aug 30 02:06:02 like last message repeated 52 times


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
