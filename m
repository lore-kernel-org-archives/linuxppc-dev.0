In-Reply-To: <411B9AF9.12494.1DA4A94@localhost>
References: <411B9AF9.12494.1DA4A94@localhost>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66FD1720-EC80-11D8-8A46-003065F9B7DC@embeddededge.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: MPC82xx enet on SCC3
Date: Thu, 12 Aug 2004 12:55:23 -0400
To: "Oliver Fuchs" <olivers.lists@gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 12, 2004, at 10:29 AM, Oliver Fuchs wrote:

> as far as I understand, my kernel (2.4.24 from ELDK3.0) is not
> prepared for Ethernet on SCC3 of the MPC82xx.

It depends completely on how you chose the multiplex
the IO pins.  There are quite a few combinations, the
well known ones (for currently supported configurations)
are already part of the file.

> It seems to be necessary to modify arch/ppc/8260_io/enet.c
> Am I right?
> Is there anyone who has done this already?

An #ifdef and two lines of #defines should be all you need,
unless you have some special BSCR or other set up needed.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
