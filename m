Message-ID: <3AA7054A.7B0B7587@mvista.com>
Date: Wed, 07 Mar 2001 23:06:34 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Prashant Patel <pmpatel@trinetcommunication.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: usb question
References: <000901c0a72b$3b43b820$4d1f76d8@kennedy>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prashant Patel wrote:
>
> Hello Everybody
>       Is usb host controller supported fully for the MPC823 processor ?

Yes, with some design restrictions.  The code is in the FSM Labs
BitKeeper linuxppc_2_5 tree.  Please download and read the Motorola
application notes associated with using host mode.  I don't remember
all of the details, but there are hardware requirements for connecting
two pins on the part (baud clock out to a Port C input).  Since you
can only load one microcode patch at a time, selecting host mode USB
means you can't use any of the device relocation patches.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
