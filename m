Message-ID: <389B8925.542A78A@netx4.com>
Date: Fri, 04 Feb 2000 21:21:25 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Pavel Roskin <pavel_roskin@geocities.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-canonical output on the serial console
References: <Pine.LNX.4.21.0002042021360.29332-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin wrote:


> It appears that when c_oflag in the termios for the serial console doesn't
> have the OPOST bit set, all the output gets lost.

That is generic serial driver behavior, and I don't even
think the data makes it to the device dependent layer in this
case.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
