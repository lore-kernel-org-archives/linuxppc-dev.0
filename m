Date: Mon, 28 Aug 2000 07:18:55 -0400 (EDT)
From: Christopher Huffine <huffine@wopr.nrl.navy.mil>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 823 ports access question
Message-ID: <Pine.LNX.3.96.1000828071718.5707A-100000@wopr.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry to write another simplistic question; hopefully
there is a simplistic answer as well:

I'm trying to figure out to write to specific
PPC ports.  For example, the Bright Star
ipEngine I have has LEDs connected to the LCD ports
from the PowerPC.  I'm looking for the right
sequence to actually write to these ports and
get these LEDs to turn on and off.

I've looked in 8xx_immap.h and I start to see
what I need to make this work (im_lcd), but I'm missing
the bigger picture.  Anyone have any example
code for anything like this?

Thanks,

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
