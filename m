Date: Tue, 11 Jul 2000 09:58:41 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, toa@pop.agri.ch,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000710164335.14195C-100000@ofey.inetnebr.com>
Message-ID: <Pine.HPX.4.10.10007110953000.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Jul 2000, Takashi Oe wrote:

> 601's BAT doesn't have G bit.  Maybe that's the problem?

No 601 BATs are completely different, see the source code in the early
init. The valid bits in not in the same (BATL or BATU), the size (limited
to 8 Mb) and protection encoding are different (only one valid bit, not Vs
and Vu, and WIMGxPP are coded as in the PTE). I think the G bit is
ignored.

Oh, and a last, but not least, point I forgot, the 601 only has the IBAT
since the BAT arrays are unified.

For the rest (i.e. nothing), 601 BAT are absolutely identical to
other PPC BATs :-(

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
