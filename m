Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: debugging kernel modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 5 Aug 2002 18:12:39 -0700
Message-ID: <7D036BD3216A084DB1BD9D62BCEAF2900884D8@mail1irv.inside.istor.com>
From: "Ken Chou" <kchou@istor.com>
To: "Brian Kuschak" <bkuschak@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is there is pointer on how to debug Linux Kernel and Statically Linked
Device Drivers?

Thanks,
Ken

-----Original Message-----
From: Brian Kuschak [mailto:bkuschak@yahoo.com]
Sent: Monday, August 05, 2002 4:01 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging kernel modules


Wolfgang has a nice tutorial on this:
http://www.denx.de/doc/TQM8xxL/debugging.html

But here's the question - is there any way to dump the
module load addresses, after the fact?  'insmod -m'
works well if you always remember to use it to load
the module.  FreeBSD has 'kldstat' which dumps module
address information at any time.  Is there anything
similar to kldstat for linux?  If not, any comments on
how hard it would be to write one?

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
