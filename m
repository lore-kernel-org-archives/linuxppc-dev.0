Message-ID: <390E078A.14325494@embeddededge.com>
Date: Mon, 01 May 2000 18:39:06 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Joshua Horvath <Josh_Horvath-AJH051@email.mot.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board boots when in BDM, hangs otherwise
References: <390DDCC0.D293406B@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joshua Horvath wrote:

> ....  If I download this program via the BDM port and run it, everything
> works fine.


Welcome to the wonderful world of BDM.   The bottom line is the BDM
software is likely initializing something in the processor that you are
not doing in your code.  This is an all too typical problem I have
seen in many organizations, and is the reason the first thing I do
is write processor boot roms and initialization, then throw the BDM
away before even starting on the kernel.

> .... Now, the weird thing
> is, if I do an "IN" command (which does some basic initialization and puts the
> processor in debug mode) and then jump to flash and execute my code, everything
> works fine.

Yes, indeed, you are missing something in your code.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
