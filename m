Message-ID: <36A4D4CE.9D957BA0@jlc.net>
Date: Tue, 19 Jan 1999 13:54:06 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>
CC: Michael Meissner <meissner@cygnus.com>, linuxppc-dev@lists.linuxppc.org,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
References: <XFMail.990119132838.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:

> I like this idea.  I'll see what I can do with it tonight.

Just copy the stuff I did for the 8xx/MBX ports in misc.c.
Add a #define string to the config process and pass it into
misc.c during compilation.

When a system has some type of environment strings you
could rummage around in there to find the default information.
An example can be found in the embedded 2.1.127 kernel tarball.
There are modifications in there that I have not yet added to
the real kernel.  It reads serial EEPROM or other NVRAM storage
commonly found on the 8xx cards.  Using any type of environment
string would allow system changes without recompiling.

Have fun :-).


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
