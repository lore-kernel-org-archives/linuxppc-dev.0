Date: Thu, 23 Mar 2000 19:55:04 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Joseph Garcia <jpgarcia@execpc.com>
Subject: Re: Synchronous SCSI at 10MB/s on Lombard? (fwd)
In-Reply-To: <38DA5D9F.53A48659@execpc.com>
Message-ID: <Pine.SOL.3.95.1000323191623.26407B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Mar 2000, Joseph Garcia wrote:

> Derek Homeier wrote:
> > Has anyone tried to set the rate for synchronous SCSI tranfer for the MESH
> > controller in the G3 series Powerbooks to 10? The kernel docs claim it does
> > 10 MB/sec on machines where the bus is internal only:
>
> I have tried it on my PDQ/300.  My SyQuest worked fine, but according to /proc,
> it was still running at 5.  however, my yamaha cdrw did not work.  set 5, it
> reports its sync speed is 4.2.  when MESH is told to max at 10, my RW is still
> recognized, reports 8.4, but does not respond to mounting, reading, nor
> writing.  It could be that the 6.6 you have achieved is still doable, but my 8.4
> is not. so setting MESH to 7 or 8 may be a safer fast speed.  havent tried it
> though.
>
I didn't know you could set it at some speed in between - I rather thought
these were basically two different settings, with 5 or 10 MB/s being the
nominal transfer rate, and actual transfer rating below that. According
to dmesg my Orb drive is found and communicated at 10MB/s, thus the 6.6
(as the 3.3 in the slower mode) would seem to be limited by the controller.
I always heard the Mac SCSI controllers were quite slow, 3-3.5 MB/s being
a common rate for the external bus. The continuous r/w performance of the Orb
itself is much higher, ~ 12 MB/s. For real world performance, I'm getting
about 4.5 MB/s read/write on larger files (in fast mode).
I had some problems with the drive initially, but they also occured with
the driver set to slow mode, and mostly seem to have settled now.
But maybe this is a safe setting only for HD devices, as I frequently hear
that you shouldn't mix HDs and CDROMs, scanners etc. on one chain, the
latter seem to tend to have worse SCSI implementation.

Thanks,
							Derek

--
Derek Homeier                                           Tel: +49-431-880-4103
Institut fuer Theoretische Physik und Astrophysik       Fax: +49-431-880-4100
der Christian-Albrechts-Universitaet                    Feet:        Room 142
D-24098 Kiel, Germany		      email:  homeier@astrophysik.uni-kiel.de
-----------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
