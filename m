From: phandel@cise.ufl.edu
Date: Fri, 3 Sep 1999 03:10:21 -0400 (EDT)
To: Alex Vallens <Vallens@Colorado.EDU>
cc: linuxppc mail list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ethernet on a PowerCenter Pro
In-Reply-To: <37CEF60F.D1AA12A4@Colorado.EDU>
Message-ID: <Pine.LNX.4.10.9909030308530.656-100000@dialup-l118.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2 Sep 1999, Alex Vallens wrote:

> Although this may be a very simple problem, I just can't get LinuxPPC 5
> to recognize the built-in ethernet controller on my Power Computing
> Power Center Pro 240. Has anyone had any success with this particular
> machine, or have any insight to the right settings under the control
> panel?

My PowerCenter Pro 210's built-in ethernet has worked fine with every
kernel I've found & made myself.  Here's what dmesg says:

eth0: MACE at 00:05:[etc.], chip revision 9.64

Just make sure you compile a kernel with PowerMac MACE ethernet support,
and you should be fine.


Thanks,
Pete

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
