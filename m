Date: Wed, 28 Mar 2001 10:23:35 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328092334.B1BB5DB9D0@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BTW: it's very important to use a latest Paulus rsync/BK _2_4 kernel as a
starting point (OR to apply an appropriate version of my patches to earlier
ones).

This is because there was a memory allocation bug in the dbdma cmd buffers
before 2.4.3-pre3 or so, which would make the whole thing very
unpredictable.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
