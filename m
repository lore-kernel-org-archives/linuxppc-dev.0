Message-ID: <3B816F4F.E3633B0C@carts.com>
Date: Mon, 20 Aug 2001 13:13:03 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HZ to MHZ, 2.4.2 kernel / update on my progress
References: <3B7D6D89.2524D838@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all the replies about the bd_info struct and the hz and mhz problem
i was having.

I got linux booting and running great on Friday, and everything seems to work
wonderfully. My problem was that linux (2.4.2) was expecting all clock freqs
in hz and ppcboot was giving them all in mhz.. i should've seem this way
sooner, but hey-at least it works now :)  After i changed that the timer code
started working correctly, and then I was able to take out the hacks I had in
the SMC serial code that had gotten the serial port to work. With the serial
code back to normal, I finally got output in user space and everything worked.
Yay!
Couldnt have done it w/o you guys either, thanks again

Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
