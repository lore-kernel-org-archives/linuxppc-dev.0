Message-ID: <38EB792D.44134968@execpc.com>
Date: Wed, 05 Apr 2000 12:34:37 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Gavin Hemphill <hemphill@drea.dnd.ca>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: XFree 4 & sound problems
References: <38EAD4E8.61CD5BCA@astro.wisc.edu> <38EAD96F.44219116@execpc.com> <38EB1645.F77935DE@drea.dnd.ca>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gavin Hemphill wrote:
> Well if its a powerbook G3 with the IBM-DYLA-28100 disk then it really
> is a hard drive problem.  SoundJam MP (for the MacOS) states in the
> readme file that on the powerbook G3 with the IBM drive you can cause
> random file corruption on the drive under certain circumstances. - they
> say "contact Apple" for a solution :-)

Yes, I have a PDQ/300, which has that particular drive.  I guess that answers
that.  I did a quick search in Apple TIL, but couldn't find anything directly
related to it.  There are mentions of Drive Setup revisions with updated UDMA
handlers.  I might still be using the original 8.5 or 8.6 drivers.  Do these
effect linux, Ben?  I'm use miboot 1.0d3.   Anyone happen to know what Apple's
solution to this is?  Is there an alternative to turning off DMA with hdparm?
the performance hit is too extreme (less than 1M/s, and CPU loaded)  Or do I
need a new drive?  (my year is up, and it looks like even though Apple cashed my
check before time, its 6 weeks to the day and have gotten nothing on my 3-year
AppleCare extention.  if something isnt in the mail today, it may be time to
call)

Fun...

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Ask yourself, Why do you seek the developer kernel?  Is it for its glory,
 or for yours?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
