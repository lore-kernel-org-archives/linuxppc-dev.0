Message-ID: <XFMail.990120152136.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <36A520DE.DCC9F600@phx.mcd.mot.com>
Date: Wed, 20 Jan 1999 15:21:36 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Johnnie Peters <jpeters@phx.mcd.mot.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Cc: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>
Cc: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        Dan Malek <dmalek@jlc.net>, Cort Dougan <cort@persephone.cs.nmt.edu>,
        Michael Meissner <meissner@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 20-Jan-99 Johnnie Peters wrote:
> 
> I will volunteer to try the patches on:
> 
> Blackhawk
> Comet
> Utah
> Mequite
> MTX
> VME2600/2700/3600
> 
> just as soon as they are available.
> 

I have put up all my patches against 2.2.0p7 at:
  ftp://ftp.linuxppc.org/gary/diffs-2.2.0p7-Jan20
These are diffs against the virgin 2.2.0-pre7.

This includes the changes to fix boot problems on my Utah box,
as well as the changes to get the PS/2 mouse working again.

I also did some restructuring of the PPC main configuration menu
so that Pmac questions are ignored if you aren't configuring for
a PowerMac.  I also added a configuration option to set the default
kernel boot line, passed to the bootstrap code.

Note: I have had persistent problems with the cache test in the
NCR driver.  It seems to work fine if I just ignore it, so I also
left it that way.  I also had to "tone down" the driver a lot,
the default of WIDE+20Mhz just doesn't cut it on my drives :-)



------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
