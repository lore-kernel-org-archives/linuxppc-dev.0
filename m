Message-ID: <19991018222353.B9665@alice.realminfo.com>
Date: Mon, 18 Oct 1999 22:23:53 -0400
From: Mike Panetta <mpanetta@realminfo.com>
To: Dan Malek <dmalek@jlc.net>, Mike Panetta <mpanetta@realminfo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux on sandpoint question
References: <19991018142931.G24248@alice.realminfo.com> <380B94BA.937F74C@jlc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <380B94BA.937F74C@jlc.net>; from Dan Malek on Mon, Oct 18, 1999 at 05:44:26PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't suppose that you know weather or not PPC Linux will run on this
board with an MPC7400 or MPC750 CPU on it do ya?  Does this board even
exist with these CPU's yet?  They don't elaborate to much on the web page.
Oh and exactly what does it take to port PPC linux to another PPC varient?
I have never done a port before and may be intrested in trying.  

Thanks,
Mike Panetta

PS: Not subscribed yet.  Will do so in the morning ;)


On Mon, Oct 18, 1999 at 05:44:26PM -0400, Dan Malek wrote:
> Mike Panetta wrote:
> > 
> > I read through the mailing list archives and I didnt see any refrence
> > to linux running on the Sandpoint eval with the MPC7400 CPU...
> > Will linux work in this configuration?  If not what parts would need
> > to be ported?  If I understand correctly the kernel supports the CPU just
> > fine.  Is this true?  Would any drivers need to be ported and what would be
> > involved?
> 
> I am currently porting the 8240 Sandpoint.  Other than the signal level
> considerations between PCI and PMC, there really aren't any driver
> differences.  I just happened to pick a PCI Ethernet card that wasn't
> supported by PPC, so I had to fix the byte ordering troubles.  All of
> the work is in properly programming the PCI bridge, everything else
> seems to fall into place.
> 
> 
> > I am not on this list so please email me directly.
> 
> So.....get on board....You may not have to ask these questions next time.
> 
> 
> 
> 	-- Dan

-- 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
