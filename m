Message-ID: <37DDF78B.C4BA5256@jlc.net>
Date: Tue, 14 Sep 1999 03:21:47 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Hugh Caley <hcaley@loomer.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA on Powerbook G3 Series
References: <37DDF029.25A4839F@loomer.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hugh Caley wrote:


> Is it possible yet to use PCMCIA on a PB G3 Series laptop?

Yep.  Do it on my Wallstreet every day.  I run an old kernel that
I patch here and there, and the pcmcia-3.0.7 that I ported a long
time ago.  It looks like Paul and others have kept it up to date.


> ... simply inserting my little Viking smart card adaptor causes a
> kernel panic every time, and having it in at boot does the same thing.


Ooooo.  I found that as well with my ATA flash cards and compact
adaptors.  I work on it from time to time, but haven't found the
problem yet.  I know that something doesn't match correctly between
the pcmcia-cs and the IDE driver.

At least other people now know....anyone have any ideas?  I have
not worked on it for a while, maybe I'll take a stab at it again.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
