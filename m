Subject: Re: Virtex II Pro/405GP
From: James Campbell <jcampbell@omnigon.com>
To: Peter Ryser <Peter.Ryser@xilinx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3CBC7F1B.FF597841@xilinx.com>
References: <1018722334.3710.3.camel@skoll.omnigon.com>
	<3CBC7F1B.FF597841@xilinx.com>
Content-Type: text/plain
Date: 16 Apr 2002 13:49:01 -0700
Message-Id: <1018990141.2034.12.camel@skoll.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-04-16 at 12:44, Peter Ryser wrote:
> James,
>
> I do have some experience with this chip :-)

Ah, good.  At least I'm not stumbling in the dark here.

> Internally, we tested the latest Linux development kernel and found that it
> works just fine on our FPGA (2VP7FF672, one CPU, eight 3.125 Gbit IOs).

Great.  We are using the 2VP7's as well, with two National DP83865 GigE
phys on the gbit IOs.  We have just recieved our kit with the Xilinx ISE
software to start playing with it, and are hoping to get our boards back
from the manufacturer next week.

I was just curious if you had to use any esoteric patches on the (v2.5
I'm assuming) kernel?  Also, did you have to worry about using a full
featured boot loader like ppcboot?  Any pointers would be helpful.

Cheers,

James Campbell

--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  DA57 E174 4769 1B9D D0DF 73E6 D639 D867 A576 A5AE
work: +1.760.804.8884 x 332       cell: +1.760.803.8476
--
I bestride this world like a Colossus.  A very small
Colussus.  Without a torch.  Made of meat.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
