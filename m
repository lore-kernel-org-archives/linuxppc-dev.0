Mime-Version: 1.0
Message-Id: <a04310100bbce446f4c17@[199.170.89.149]>
In-Reply-To: <1068000383.692.132.camel@gaston>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>	
 <1067842481.17970.8.camel@gaston>
 <a04310106bbcd1501d614@[199.170.89.118]>	
 <1067937269.680.92.camel@gaston>
 <a04310102bbcda40d92fc@[199.170.89.159]>	
 <1067985081.707.124.camel@gaston>
 <a04310101bbce0854283b@[199.170.89.118]> <1068000383.692.132.camel@gaston>
Date: Wed, 5 Nov 2003 00:20:32 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:46 +1100 11/05/2003, Benjamin Herrenschmidt wrote:

>Ok. I need to look at the 53C96 specs to see if it's really similar
>to MESH.

Nitpick:  53CF96.  The 53C96 is an earlier chip which does not
support Fast SCSI.  The 53C96 was used in the Quadras to provide the
only SCSI bus in those machines.  The 53CF96 was used in the 8100 and
9100 to provide the Fast SCSI bus.

The MESH is marked 343S1146.

>Ok. Strange then. I was sure it was internal. It is internal to
>Hydra (the "CHRP" MacIO chip).

It went internal after the PowerSurge machines.   The Beige G3 lacks
a Fast SCSI bus and SCSI isn't built in after that.  However,
according to an Apple Tech note, one of the Blue & White chips has an
internal MESH cell because some part of the OS or firmware expects to
find a MESH.   However, the MESH connections are not carried to the
exterior of the chip.

>>  As an aside, it's too bad that CURIO's pinout is not available from
>>  AMD.   They have datasheets for several related chips on their site.
>>  I guess CURIO was a custom job for Apple or something.
>
>It's a 53c94 afaik. We do have a driver for it. And Apple released
>both their MESH and Curio drivers in darwin.

The SCSI cell in CURIO is a 53C94, but CURIO provides SCSI, ethernet
and serial port support all in one chip.   So the pinout of the 53C94
doesn't tell one about the pinout of CURIO, except it does identify
some of the pins which must be present on CURIO somewhere.

In fact, a great deal of the pinout of GC would be revealed if one
had a pinout for CURIO, because much of what GC does is connect to
CURIO.

It's interesting that the drivers are available in Darwin.  Thank
you.  I'm going to have to brush off those programming skills, I
think.   That's such a huge learning curve in my case, though.

CURIO was used from the NuBus power macs (or was it first in the AV
Quadras?) through the x500 series.   It had quite a long life.   It
is marked AM79C950KC.

>It would be interesting if someone acutally had time to review those
>and find out which of the HW bugs they work around in darwin for which
>we would need equivalent fixes in linux :)

Yes, it would.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
