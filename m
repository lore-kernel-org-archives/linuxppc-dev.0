Message-ID: <3823292A.3D3E8BFE@netx4.com>
Date: Fri, 05 Nov 1999 13:59:54 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: dmalek@jlc.net, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.or, beatson_mark@bucks.si.com,
        vanbaren_gerald@bucks.si.com
Subject: Re: Trying to find out the current state of Linux on a MPC 8260
References: <m11jkpn-001Sw7C@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

>         2) Has anybody gotten Linux kernel to run on the EST Corp. SBC 8260
>            board?  Or, is anybody is the process of doing this?

Yes.  Yes.

> 
>         3) Has anybody gotten Linux to run on the 8240/8260?  If so,
>            are there some hints or recipes available?

Yes.



>            Has this been done?  If so, where can I get the source?


A very fine company has paid me money to port Linux/PPC to the
EST 8260 (not EST).  I have it nearly completed and when they are
satisfied it meets their needs I will update the CVS according to
their wishes.  There is some software associated with it that
was not derived from GPL, althought it would be nice to include
that as GPL in the Linux tree.  The port will include support
for the serial ports, Ethernet on SCCs, and 10/100 on the FCCs.

Motorola gave me an 8240 Sandpoint that I have been using in
my free time to port Linux/PPC.  Since this is a personal
contribution of mine, people that pay me obviously have priority :-).
I should update CVS with the current sources....there are still
some bugs in the configuration of the interrupt controller for
the ISA bridge and 8259.
 

>         4) What is best way to get in touch with embedded MPC 82xx
>            developers?


You just did it.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
