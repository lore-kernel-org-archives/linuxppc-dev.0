Date: Fri, 26 Mar 1999 22:27:59 -0800
Message-Id: <199903270627.WAA18114@aragorn.shiresoft.com>
From: Guy Sotomayor <ggs@shiresoft.com>
To: dje@watson.ibm.com
Cc: paubert@iram.es, linuxppc-dev@lists.linuxppc.org
Reply-To: ggs@shiresoft.com
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers 
In-Reply-To: <9903261613.AA48254@marc.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> Gabriel> Do 64 bit PPC processors that can be bought as chips (not in a system)
> 
> Gabriel> exist (i.e., can you buy a Power3 in a BGA package and the chipset
> that
> Gabriel> goes with) ? 
> 
>      I doubt it.  The Power3 comes from the server organization and is
> intended for their use.  IBM, however, does understand customer demand:
> if there was "enough" market interest, I am sure that it would find a way
> to sell it.  The Power3 processor price is nowhere near a PPC750 or G4 and
> does not include AltiVec.
> 
Actually I think the 64bit PPCs are called PowerPC II.  They're reasonably
nice chips last time I looked.  They are expensive to put together in a
system (ie 8MB L2, 128bit data bus, etc).  Also the 6xx bus is a split
transaction bus, so the bus controllers are a bit more complex too.  I
also think that all the data paths are ECC'd with parity on addresses. 
For a good example on what type of systems are built using these things,
look at the S70 Advanced server.


TTFN - Guy



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
