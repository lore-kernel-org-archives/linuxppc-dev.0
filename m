Date: Thu, 22 May 2003 13:50:28 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: Semi hosting with BDI2000 BDM ?
To: "Milton D. Miller II" <miltonm@realtime.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <3ECC2CE4.26EFADED@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <200305210434.h4L4YOM0063233@sullivan.realtime.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


That looks to be what I want if I'm reading the code correctly - shame there is no
comment about what the hvc module is actually _supposed_ to do. I'd like to optimise
the i/o via the debugger a little to your implementation (I think!! - i.e. more
responsive that once a second but thats not critical) but a gdb script that loops
round pushing and pulling data would do it I reckon.

Perhaps someone on the list uses a Lauterbach debugger which _does_ support
semi-hosting - be interested in how they do it...

Cheers

--
Robin Gilks
Senior Design Engineer              Phone: (+64)(3) 357 1569
Tait Electronics                          Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
