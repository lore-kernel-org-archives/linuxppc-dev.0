Message-ID: <38C26453.3668A644@iiic.ethz.ch>
Date: Sun, 05 Mar 2000 14:42:43 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith
 r128
References: <Pine.LNX.4.21.0003041753480.1870-100000@idd-01.imbc.gr> <00030413590600.00885@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Hendricks wrote:

> Here is the patch to fix the cursor for 16bpp and 8bpp for XFree 4.0 r128.
> (It is attached). It is almost exactly what you sent to me earlier.

This looks a bit complicated to me.

Doesn't it help adding BIT_ORDER_IN_BYTE_MSB_FIRST to the HW cursor flags or
something? It works in the glint driver (look at pm2_accel.c or pm2_dac.c)


> By the way, true 16 bit depth (565) does not work on my machine. The screen
> comes up but everything is very very green!
>
> Reverting to 16bpp and 15 depth (555) works fine.

Does it report the correct RGB weight?


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
