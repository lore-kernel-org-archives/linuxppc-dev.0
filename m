Date: Sat, 10 Jan 2004 11:37:31 +1100
From: Anton Blanchard <anton@samba.org>
To: Bill Noffsinger <bnoffsi@acis.ufl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux on IBM 9076 nodes
Message-ID: <20040110003731.GD23038@krispykreme>
References: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Our lab has recently acquired a 48-node IBM SP configuration based on
> 4-way "Winterhawk-II" Power3-2 wide nodes with 8 GB memory. I see on the
> Linuxppc site (boxes) that Linux is known to work on 9076-SP nodes
> (ours). How difficult is the port? IBM does not support Linux on the
> 9076 but does on the newer Power4 pSeries units.

We've booted linux on winterhawks in the past, there was one weird
problem where we allocated memory for RTAS too high but that should be
fixed.

As pointed out we have no support for the switch unfortunately.

One of our build machines here is a nighthawk (16 way 9076) and it works
nicely in case anyone has a cluster of these lying around :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
