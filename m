Date: Fri, 3 Sep 1999 17:17:20 +0200
From: Hubert Figuiere <hfiguiere@businessobjects.com>
To: phandel@cise.ufl.edu
Cc: linuxppc mail list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ethernet on a PowerCenter Pro
Message-ID: <19990903171720.F17769@rhodan.businessobjects.com>
References: <37CEF60F.D1AA12A4@Colorado.EDU> <Pine.LNX.4.10.9909030308530.656-100000@dialup-l118.cise.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9909030308530.656-100000@dialup-l118.cise.ufl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to phandel@cise.ufl.edu <phandel@cise.ufl.edu>:

> > Although this may be a very simple problem, I just can't get LinuxPPC 5
> > to recognize the built-in ethernet controller on my Power Computing
> > Power Center Pro 240. Has anyone had any success with this particular
> > machine, or have any insight to the right settings under the control
> > panel?
> 
> My PowerCenter Pro 210's built-in ethernet has worked fine with every
> kernel I've found & made myself.  Here's what dmesg says:
> 
> eth0: MACE at 00:05:[etc.], chip revision 9.64

If I recall correctly, PCPro 240 use a DEC chip for Ethernet. I
must admit, I haven't booted Linux for a long time on my
PowerCenter, so I'm not really sure.
Try using DEC 21x40 card support.


Hub

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
