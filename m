From: linas@austin.ibm.com
Date: Fri, 9 Jan 2004 12:32:32 -0600
To: Bill Noffsinger <bnoffsi@acis.ufl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux on IBM 9076 nodes
Message-ID: <20040109123231.A52402@forte.austin.ibm.com>
References: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>; from bnoffsi@acis.ufl.edu on Fri, Jan 09, 2004 at 12:33:15PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 09, 2004 at 12:33:15PM -0500, Bill Noffsinger wrote:
>
> Our lab has recently acquired a 48-node IBM SP configuration based on
> 4-way "Winterhawk-II" Power3-2 wide nodes with 8 GB memory. I see on the
> Linuxppc site (boxes) that Linux is known to work on 9076-SP nodes
> (ours). How difficult is the port?

Port what?

I've recompiled & run both 2.4-marcelo, 2.4-redhat, 2.4-suse (which
are all very different) and 2.6-torvalds kernels on a 2-way power3 box
and 'it just works'.  I can't imagine why it wouldn't 'just work' on
an SP.

I'm guessing that the hard part for you will be to get the interconnect
between the machines running.  I assume this will need some funny
device driver for whatever the interconnect technology is (which you
didn't mention).

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
