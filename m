Message-ID: <380B94BA.937F74C@jlc.net>
Date: Mon, 18 Oct 1999 17:44:26 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Mike Panetta <mpanetta@realminfo.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux on sandpoint question
References: <19991018142931.G24248@alice.realminfo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Panetta wrote:
> 
> I read through the mailing list archives and I didnt see any refrence
> to linux running on the Sandpoint eval with the MPC7400 CPU...
> Will linux work in this configuration?  If not what parts would need
> to be ported?  If I understand correctly the kernel supports the CPU just
> fine.  Is this true?  Would any drivers need to be ported and what would be
> involved?

I am currently porting the 8240 Sandpoint.  Other than the signal level
considerations between PCI and PMC, there really aren't any driver
differences.  I just happened to pick a PCI Ethernet card that wasn't
supported by PPC, so I had to fix the byte ordering troubles.  All of
the work is in properly programming the PCI bridge, everything else
seems to fall into place.


> I am not on this list so please email me directly.

So.....get on board....You may not have to ask these questions next time.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
