Message-ID: <379E8995.31CA136B@cadvision.com>
Date: Tue, 27 Jul 1999 22:39:49 -0600
From: Neil Jolly <jollyn@cadvision.com>
MIME-Version: 1.0
To: ian geiser <geiseri@msoe.edu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        LinuxPPC List <linuxppc-user@lists.linuxppc.org>
Subject: Re: G3 Upgrade Questions....
References: <379E3513.738D0449@msoe.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian geiser wrote:

> Hello,
>     I just installed a G3 upgrade card into my powercenter132
>     It is a 400Mhz with 1Meg at 200Mhz....
>     It registers under MacOS perfectly but i get the following under
>     proc/cpuinfo:
>     processor       : 0
>     cpu             : 750
>     temperature     : 0 C            <--Is this correct?!
>     clock           : 195MHz        <-- Is this correct?!
>     revision        : 130.1
>     bogomips        : 399.77
>     zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/1084 (0%)
>     machine         : Power Macintosh
>     motherboard     : AAPL,7300 MacRISC
>     memory          : 112MB
>
>     it only registers 195 Mhz and 0C for the temp... is the correct?
>     i am running Kernel 2.2.10

Here's a peek at my cpu info. A 233 G3 clocked to 292 with 83mhz bus, and
runs around 106 degrees F. Obviously the temp is not accurate, but clock
seems to be pretty close.

processor       : 0
cpu             : 750
temperature     : 0 C
clock           : 290MHz
revision        : 2.2
bogomips        : 581.63
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/558 (0%)
machine         : Power Macintosh
motherboard     : AAPL,Gossamer MacRISC
L2 cache        : 512K unified pipelined-syncro-burst
memory          : 96MB


Neil


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
