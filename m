Date: Tue, 7 Sep 1999 21:13:35 -0400 (EDT)
From: "Joshua M. Thompson" <funaho@jurai.org>
To: Paul.Mackerras@cs.anu.edu.au
cc: jquinn@nortelnetworks.com, toa@pop.agri.ch,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
In-Reply-To: <199909080044.KAA02252@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9909072111420.16096-100000@ifurita.jurai.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Sep 1999, Paul Mackerras wrote:

> mca_53c9x driver is probably worth a look.  I used the esp.c driver as
> a reference as the ESP chip in Suns is apparently a 53c96 and has
> marked similarities to the 53c94.  There appear to be no fewer than 4
> esp drivers there. :-)

You should be able to do something similar to what mac_esp.c (the driver
for the ESP chip on the Quadra 660AV and 840AV) does...that is, just
enough work to find the chip and get the interrupts and then pass the buck
to the NCR53C9x.c driver.

-- 
funaho@jurai.org             | Voodoo is a very interesting religion for the
http://www.jurai.org/~funaho | whole family, even those members of it who are
                             | dead.
                             |  -- (Terry Pratchett & Neil Gaiman, Good Omens)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
