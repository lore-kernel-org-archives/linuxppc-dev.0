Message-ID: <3903C55C.DBC66391@embeddededge.com>
Date: Sun, 23 Apr 2000 23:54:04 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: zzh <david-1z@263.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory map
References: <3903BE73.04522@mta2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zzh wrote:

> In fact,i am hacking with a motorola 8260 ads board.

I just checked in all of my 8260 changes.  You may find them
helpful.

> ....I download the
> mpc8xx to start with.I find it is in fact quite different.

Yes, it is quite different.....It is just a 603 with a bigger
CPM.


> my board's IMMR=0f000000,so change this to f0000000 in ROM code

That's a good thing.  The current configuration assumes the
IMMR at 0xf0000000.  Map the board BCSRs up in that range and get
all of it with one BAT.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
