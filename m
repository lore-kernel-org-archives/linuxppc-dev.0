From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Derrik Pates <dpates@dsdk12.net>,
	Stefan Piger <piger@rvs.uni-hannover.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
Date: Thu, 22 Nov 2001 19:21:11 +0100
Message-Id: <20011122182111.9961@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.40.0111220058320.14868-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.40.0111220058320.14868-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I actually just had the same thing happen, only the entire console froze,
>X and all. I don't know if the kernel was still working or not, I didn't
>have another machine connected at the time. However, this is actually an
>improvement for me - the ohci1394 module doesn't lock the PMU up and cause
>the system to suddenly shutdown (this is a FireWire iBook). If I boot the
>system with the FireWire device - a QPS CD-RW drive - plugged in, all is
>fine.

In Stefan's case, it appears to be the transmit DMA of the chip stalling
for some unknown reason. I suggest moving that discussion to the
linux1394-devel list as I really don't know what may be going on.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
