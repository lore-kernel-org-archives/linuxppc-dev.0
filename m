From: supas100@astrophysik.uni-kiel.de (Derek Homeier)
Message-Id: <199909171607.SAA07046@juliet.astrophysik.uni-kiel.de>
Subject: Re: New booter
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 17 Sep 1999 18:07:51 +0200 (MET DST)
Cc: bh40@calva.net
In-Reply-To: <199909170500.AAA08016@lists.linuxppc.org> from "Linux PPC Developer Digest" at Sep 17, 99 00:00:48 am
Reply-to: Derek Homeier <homeier@astrophysik.uni-kiel.de>
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Sep 1999 12:47:15 +0200, Benjamin Herrenschmidt <bh40@calva.net> wrote:
> 
> Back to miBoot, I'll try to get it working first (it seems to work but
> the kernel hangs, I don't know why yet and I won't have time to look into
> this until this week-end). It doesn't solve all the problems since making
> bootable CDs (which is my main goal for now) requires a valid driver on
> the CD (only MacOS Toast can do that to my knowledge) and using this
> trick to boot from the HD also requires a valid MacOS driver on the disk.
> 
> I do have some plans to extend the mecanism further and make a CD driver
> to avoid relying on Toast and eventually a hard disk driver too (I do
> have a prototype SCSI driver but this requires licenced patches from
> Apple to make something really useable).
> 
I think the latest mkhybrid <ftp://ftp.ge.ucl.ac.uk/pub/mkhfs/> has provisions 
for installing a boot driver, but it's highly experimental yet. You'd still
need the driver itself, also.

Thanks for your efforts,
							Derek

-- 
Derek Homeier                                           Tel: +49-431-880-4103
Institut fuer Theoretische Physik und Astrophysik       Fax: +49-431-880-4100
der Christian-Albrechts-Universitaet                    Feet:        Room 142
D-24098 Kiel, Germany		      email:  homeier@astrophysik.uni-kiel.de
-----------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
