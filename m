Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 13:28:56 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111141318380.20197-100000@www.cgsoftware.com>
In-Reply-To: <Pine.LNX.4.33.0111141318380.20197-100000@www.cgsoftware.com>
MIME-Version: 1.0
Message-Id: <20011114182613.TIGV16532.tomts17-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

On November 14, 2001 01:20, Daniel Berlin wrote:
> Just a note, on the tibook rev b, the EDID is in EDID1 for the LCD.
> No idea if it'll make an EDID2/EDID if you plug in an external monitor.

Arrgghh!  Okay, I guess knowing the name of the OF EDID block is not going
to be easy!

My tree has both "DFP,EDID", and "LCD,DFP" so my code only looks for:

DFP,EDID
LCD,EDID
and
EDID

I will add "EDID1" also (and "EDID2") just to make sure nothing breaks
along the way.

Ben is correct here, perhaps we should do our own I2C to grab our own EDID
block directly from the monitor and not play the "what name did OF give
it" game.

I have not looked at the I2C code to see how complex it is.  Does anyone
have any working code or sample code I can look at?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
