Date: Mon, 21 Jun 1999 20:37:08 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-users@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: precompiled 2.2.10 kernel available
In-Reply-To: <199906180718.RAA11040@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990621201542.23566A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


did the protocol of /dev/usbmouse have to change? :( now it appears as a
ps2 mouse not a busmouse. x can't understand it either way but i'm able to
use my usb mouse in x by having gpm use it as a ps2 mouse and export it,
as in

gpm -t ps2 -R

and then have X use gpm

Section "Pointer"
 Protocol "mousesystems"
 Device "/dev/gpmdata"
EndSection

is there an easier way?

> *NOTE:* This kernel includes Linus' USB stack, which (in my version)

Brad
brad@pht.com | http://www.pht.com/~brad/




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
