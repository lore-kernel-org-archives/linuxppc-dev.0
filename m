Date: Thu, 15 Apr 1999 18:00:13 -0400
From: "Scott R. Every" <scott@emji.net>
Reply-To: "Scott R. Every" <scott@emji.net>
To: David McWherter <dtm@vramp.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: How to create install disks???
Message-ID: <31368889.3133188013@imac.emji.net>
In-Reply-To: <Pine.NEB.3.96.990415165546.10875D-100000@water.vramp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Progess!

I have the install disk boating my kernel...but it says it can't find root
fs
and reboots after 180 seconds...

which ramdisk is supposed to be used for v4.1, v5, etc?

thanx

s

--On Thu, Apr 15, 1999 4:57 PM -0400 David McWherter <dtm@vramp.net> wrote:

> PS: Bad O_magic (I *think* it's O, not 0) indicates the
> OF tried to load a .coff file, and failed, seemingly because
> the coff was corrupted.  I find that some coffs that I've
> tried to build exhibit this problem.  
> 
> -David
> 
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>        David T. McWherter     dtm@waterw.com
> 
> On Thu, 15 Apr 1999, Scott R. Every wrote:
> 
>> ok, i got my ans botting and running finally so i am now working on boot
>> disks...the error message I keep getting:
>> loading XCOFFbad 0_magic
>> 
>> any ideas what this means and how i could fix it?
>> 
>> s
>> 
>> --On Wed, Apr 7, 1999 3:19 PM -0400 David McWherter <dtm@vramp.net>
>> wrote:
>> 
>> > Ahhh...here we go:
>> > 
>> > ftp://linuxppc.cs.nmt.edu/pub/linuxppc/distributions/R4/RedHat/boot/
>> > 
>> > Things seem to have changed a wee bit...so I'll give it a shot with
>> > the stuff in the URL above RSN...
>> > 
>> > -David
>> > 
>> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> >        David T. McWherter     dtm@waterw.com
>> > 
>> > On Wed, 7 Apr 1999, Scott R. Every wrote:
>> > 
>> >> nope.  i haven't gotten my ANS working yet  ;(
>> >> 
>> >> about all i can do is help test installers.  once i get things
>> >> installed, i am sure i could help build installer's given pointer
>> >> and/or simple instructions...
>> >> 
>> >> I've done that type of thing on intel linux, but not ppc.
>> >> 
>> >> s
>> >> 
>> >> --On Wed, Apr 7, 1999 2:44 PM -0400 David McWherter <dtm@vramp.net>
>> >> wrote:
>> >> 
>> >> > Can you build a working installer.coff given an arbitrary kernel?
>> >> > :-)
>> >> > 
>> >> > -David
>> >> > 
>> >> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> >> >        David T. McWherter     dtm@waterw.com
>> >> > 
>> >> > On Wed, 7 Apr 1999, Scott R. Every wrote:
>> >> > 
>> >> >> cool, if there's anything i can do to help, let me know.
>> >> >> 
>> >> >> s
>> >> >> 
>> >> >> --On Wed, Apr 7, 1999 2:35 PM -0400 David McWherter <dtm@vramp.net>
>> >> >> wrote:
>> >> >> 
>> >> >> > We did that...but we just built a barebones root filesystem on a
>> >> >> > Zip disk, and plopped the kernel and installer on there, and
>> >> >> > installed from it.
>> >> >> > 
>> >> >> > -David
>> >> >> > 
>> >> >> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> >> >> >        David T. McWherter     dtm@waterw.com
>> >> >> > 
>> >> >> > On Wed, 7 Apr 1999, Scott R. Every wrote:
>> >> >> > 
>> >> >> >> Cool.  I'll be happy to help test once you've got a working
>> >> >> >> version... I'm mostly interested in being able to use the RedHat
>> >> >> >> ftp install to the internal drive.  I have an ANS 700 BTW...
>> >> >> >> 
>> >> >> >> thanx
>> >> >> >> 
>> >> >> >> s
>> >> >> >> 
>> >> >> >> --On Wed, Apr 7, 1999 2:06 PM -0400 David McWherter
>> >> >> >> <dtm@vramp.net> wrote:
>> >> >> >> 
>> >> >> >> > Yep.  The one I've been working on doesn't seem to work yet
>> >> >> >> > :-) I'm not sure, but I'm just guessing that there's a
>> >> >> >> > problem with the build scripts I'm using or the kernel
>> >> >> >> > version is too new for the build scripts (and something needs
>> >> >> >> > to be changed).
>> >> >> >> > 
>> >> >> >> > -David
>> >> >> >> > 
>> >> >> >> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> >> >> >> >        David T. McWherter     dtm@waterw.com
>> >> >> >> > 
>> >> >> >> > On Wed, 7 Apr 1999, Scott R. Every wrote:
>> >> >> >> > 
>> >> >> >> >> any word on that updated ANS installer you were working on
>> >> >> >> >> which supported the internal scsi and ethernet ports?
>> >> >> >> >> 
>> >> >> >> >> s
>> >> >> >> >> 
>> >> >> >> >> --On Wed, Apr 7, 1999 1:56 PM -0400 David McWherter
>> >> >> >> >> <dtm@vramp.net> wrote:
>> >> >> >> >> 
>> >> >> >> >> > It seems that the problem is that we never archived the
>> >> >> >> >> > FTP  area on our  old system and restored it on the new
>> >> >> >> >> > Linux setup. Over the next day or so I'll be moving to get
>> >> >> >> >> > things back up.
>> >> >> >> >> > 
>> >> >> >> >> > -David
>> >> >> >> >> > 
>> >> >> >> >> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> >> >> >> >> >        David T. McWherter     dtm@waterw.com
>> >> >> >> >> > 
>> >> >> >> >> > On Tue, 6 Apr 1999, Dave Beck wrote:
>> >> >> >> >> > 
>> >> >> >> >> >> So, we just moved hellfire.dusers.drexel.edu from AIX to
>> >> >> >> >> >> LinuxPPC last weekend (with our new installer).  This may
>> >> >> >> >> >> be part of the problem you are having accessing the
>> >> >> >> >> >> hellfire sources and what not.  Dave McWherter just
>> >> >> >> >> >> finished his lcd driver and is integrating that into the
>> >> >> >> >> >> linux source tree. We are also working on resolution
>> >> >> >> >> >> switching for X, but that is a tad more difficult.
>> >> >> >> >> >> 
>> >> >> >> >> >> Quoting Darron Froese (darron@calgary.westworld.ca):
>> >> >> >> >> >> > > I'm trying to access the latest patched kernel source
>> >> >> >> >> >> > > tree from hellfire but everything appears to have
>> >> >> >> >> >> > > disappeared (is that an oxymoron??) from the ftp site.
>> >> >> >> >> >> > > I know you guys were supposed to be getting a network
>> >> >> >> >> >> > > pipe upgrade from scanning the mailing list archives -
>> >> >> >> >> >> > > did the disks with the ftp stuff on them go offline
>> >> >> >> >> >> > > because of that?
>> >> >> >> >> >> > 
>> >> >> >> >> >> > Kevin,
>> >> >> >> >> >> > 
>> >> >> >> >> >> > If it's the kernel source that you want, I've got most
>> >> >> >> >> >> > of it mirrored here:
>> >> >> >> >> >> > 
>> >> >> >> >> >> > ftp://ans.odi.ca//pub/archives/linux/kernel/ans-specifi
>> >> >> >> >> >> > c/
>> >> >> >> >> >> > ftp://ans.odi.ca//pub/archives/linux/kernel/source/linu
>> >> >> >> >> >> > x-2 .2. 4.a ns. tgz
>> >> >> >> >> >> > ftp://ans.odi.ca//pub/archives/linux/kernel/source/linu
>> >> >> >> >> >> > x-p mac -2. 2.1 .an s.tgz
>> >> >> >> >> >> > 
>> >> >> >> >> >> > > Also, can anyone point me in the right direction for
>> >> >> >> >> >> > > information or source code for an installer?  It seems
>> >> >> >> >> >> > > all the right pieces and patches are there to get the
>> >> >> >> >> >> > > ANS to boot the way it should, if only there was an
>> >> >> >> >> >> > > installer that incorparated those patches and the
>> >> >> >> >> >> > > latest kernel.  I'm basically too lazy to go through
>> >> >> >> >> >> > > the whole ANS install process, especially if its just
>> >> >> >> >> >> > > a matter of compiling a new installer or patching an
>> >> >> >> >> >> > > old one. Of course, I guess if it was that easy,
>> >> >> >> >> >> > > someone would have done it (but then again, who knows
>> >> >> >> >> >> > > how many people actually have these beasts - someone
>> >> >> >> >> >> > > GAVE me mine :)
>> >> >> >> >> >> > 
>> >> >> >> >> >> > I don't think that the new installer is
>> >> >> >> >> >> > ready/working/etc yet - only the guys that are working
>> >> >> >> >> >> > on it know. I do know though, that the installation
>> >> >> >> >> >> > procedure at Demonsys works fine. It's at:
>> >> >> >> >> >> > 
>> >> >> >> >> >> > http://www.demonsys.com/ans/
>> >> >> >> >> >> > 
>> >> >> >> >> >> > --
>> >> >> >> >> >> > Darron
>> >> >> >> >> >> > darron@calgary.westworld.ca - WestWorld Computers
>> >> >> >> >> >> > <http://i.am/darron/>
>> >> >> >> >> >> 
>> >> >> >> >> >> -- 
>> >> >> >> >> >> Dave Beck 
>> >> >> >> >> >> dave@arginine.umdnj.edu                 Sites of interest
>> >> >> >> >> >> (set 3): Computer Science and Biology
>> >> >> >> >> >> http://selene.biochem.uga.edu/tutorial/ Drexel University,
>> >> >> >> >> >> Philadelphia PA      http://www.cold.org/
>> >> >> >> >> >> 
>> >> >> >> >> 
>> >> >> >> >> 
>> >> >> >> >> 
>> >> >> >> >> --
>> >> >> >> >> Scott R. Every - mailto:scott@emji.net
>> >> >> >> >> EMJ Internet - http://www.emji.net
>> >> >> >> >> voice : 1-800-548-2319  fax : 1-919-363-4423
>> >> >> >> >> 
>> >> >> >> 
>> >> >> >> 
>> >> >> >> 
>> >> >> >> --
>> >> >> >> Scott R. Every - mailto:scott@emji.net
>> >> >> >> EMJ Internet - http://www.emji.net
>> >> >> >> voice : 1-800-548-2319  fax : 1-919-363-4423
>> >> >> >> 
>> >> >> 
>> >> >> 
>> >> >> 
>> >> >> --
>> >> >> Scott R. Every - mailto:scott@emji.net
>> >> >> EMJ Internet - http://www.emji.net
>> >> >> voice : 1-800-548-2319  fax : 1-919-363-4423
>> >> >> 
>> >> 
>> >> 
>> >> 
>> >> --
>> >> Scott R. Every - mailto:scott@emji.net
>> >> EMJ Internet - http://www.emji.net
>> >> voice : 1-800-548-2319  fax : 1-919-363-4423
>> >> 
>> 
>> 
>> 
>> --
>> Scott R. Every - mailto:scott@emji.net
>> EMJ Internet - http://www.emji.net
>> voice : 1-800-548-2319  fax : 1-919-363-4423
>> 



--
Scott R. Every - mailto:scott@emji.net
EMJ Internet - http://www.emji.net
voice : 1-800-548-2319  fax : 1-919-363-4423

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
