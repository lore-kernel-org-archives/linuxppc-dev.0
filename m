Message-ID: <38341F92.5975D96B@netx4.com>
Date: Thu, 18 Nov 1999 10:47:30 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jim Chapman <jim.chapman@iname.com>
CC: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: configuring swap on a diskless mpc860 embedded target
References: <38340F9F.E7A9CC63@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Chapman wrote:
> 
> Is anyone using an NFS-mounted swap file on an mpc860 diskless system?


Ummm...no.....That's not very high on the list, as embedded
products don't usually swap.....

I don't know much about swapping, except that all of the
systems I have will use an exclusive disk partition for that.
There may be some assumptions in the code about underlying
media....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
