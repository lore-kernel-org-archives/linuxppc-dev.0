From: Benjamin Herrenschmidt <bh40@calva.net>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, <linuxppc-dev@lists.linuxppc.org>,
        <dri-devel@lists.sourceforge.net>
Subject: Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
Date: Sat, 5 Aug 2000 20:43:51 +0200
Message-Id: <20000805184351.19510@192.168.1.10>
In-Reply-To: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> At 32 bit, it flickers badly on my Pismo, probably because it only has
>8 megs
>> of VRAM. (These messages appear in the log:
>> (EE) r128(0): Unable to reserve depth buffer
>> (EE) r128(0): Unable to reserve texture space in frame buffer
>> ) Curious how it works out for people with more...
>
>Not enough memory for all the buffers indeed, you could try with a lower
>res (if prismo allows that) to save some memory.

The Pismo allows that by scaling the LCD, but I don't think code for that
is implemented in the XFree r128 driver (I didn't check lately).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
