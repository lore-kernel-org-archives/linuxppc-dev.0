Message-ID: <37CB8D07.FE7D3D62@wanadoo.fr>
Date: Tue, 31 Aug 1999 10:06:31 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "David D. Kilzer" <ddkilzer@computer.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
References: <v03130301b3f116a864e2@[192.168.1.1]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David D. Kilzer" wrote:
> 

> Serial driver version 4.27 with no serial options enabled
> Machine check in kernel mode.

I'd look into your serial driver config options. There are some that
don't work on the PPC.

And if you run the oops message through ksymoops (to be found in
/usr/src/linux/scripts/ksymoops/), you get more meaningful addresses.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
