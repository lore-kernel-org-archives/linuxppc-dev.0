Message-ID: <3BBDDF94.9728840D@labs.mot.com>
Date: Fri, 05 Oct 2001 11:28:04 -0500
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: John_McRoberts@mitel.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hard disk and segmentation violation.
References: <85256ADC.00515614.00@kanmta01.software.mitel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just had this exact same problem earlier this week. I read the archives regarding
the use of ioremap in early kernel initialization. Still I don't yet have a good
grasp on what space can be mapped 1:1 in arch/ppc/mm/init.c and what cannot. For
now my solution was to move the harddisk up to 0xF8000000.  I chose that space only
because other boards use that address for IO space. Apparently this can be 1:1
mapped. I don't get seg faults with fdisk anymore.

Steve

John_McRoberts@mitel.com wrote:

> I seem to have a problem with fdisk whereby I get an segmentation violation to
> the hard disk, address 0x43000000 +. I have performed and ioremap to this area.

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
