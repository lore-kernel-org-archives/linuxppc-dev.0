Date: Wed, 8 Sep 1999 10:44:37 +1000
Message-Id: <199909080044.KAA02252@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: jquinn@nortelnetworks.com
CC: toa@pop.agri.ch, jquinn@nortelnetworks.com,
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
In-reply-to: <14293.24696.450823.134283@gargle.gargle.HOWL>
	(jquinn@nortelnetworks.com)
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37BC482D.7EB2A4AF@pop.agri.ch> <14273.21611.490430.724369@gargle.gargle.HOWL> <37D3A439.3A41F55@pop.agri.ch> <199909070043.KAA01407@tango.anu.edu.au> <14293.24696.450823.134283@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can you tell us what the difference is between this driver and the generic
> 53c94 driver in the same directory?  Also, is there a source of docs other
> than the code there (for us SCSI newbies :-)?

I assume you're talking about the mca_53c9x.c driver?  I don't think
that existed when I started doing mac53c94.c.  I would expect that the
main differences are in the areas of DMA and interrupt handling.  The
mca_53c9x driver is probably worth a look.  I used the esp.c driver as
a reference as the ESP chip in Suns is apparently a 53c96 and has
marked similarities to the 53c94.  There appear to be no fewer than 4
esp drivers there. :-)

I never found a definitive manual or data sheet on the 53c94,
unfortunately.  For documentation on the SCSI-2 standard, I have a
late draft that I got by ftp from somewhere.  The actual final
standard isn't available on the web as it costs real money. :-(

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
