Message-ID: <20000217105324.29583.qmail@web210.mail.yahoo.com>
Date: Thu, 17 Feb 2000 02:53:23 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: hfs+
To: Brad Boyer <flar@pants.nu>, Dan Bethe <dan_bethe@yahoo.com>
Cc: marv <omarvo@hotmail.com>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
This guy might be able to help,
he is a linux fan & an old friend & knows the mac as
well as anyone, he is responsible for the apple's
internal download/installation software &
always has to get his hands dirty with mac filesystem
internals.

He is currently porting his partition libraries
to MacOS X.

Ken Fitzgerald Smith metro@tinet.ie

He usually is a bit difficult at first
but is a real pussycat once you get to know him.

If he isn't able to help directly hopefully
he should be able to get you more docs or
point you in the right direction if you run
into problems.

--- Brad Boyer <flar@pants.nu> wrote:
>
> Dan Bethe wrote:
> > 	Bless you.  Lots of people would be grateful.
> This would be
> > tremendously useful, especially if it could be the
> main crossplatform,
> > mature, multiuser, unix-like filesystem to share
> data between Linux and
> > MacOS 8/9/10 on the same machine.
> > 	Beware of duplicate work.  There are the
> hfsutils, which are user
> > space utilities.  And there is something that's
> either a library or a
> > kernel module, that someone's working on, which is
> nonfunctional at
> > this time.
> > 	Do searches on lists.linuxppc.org to find who's
> doing what.  We've
> > recently discussed this within the last 2 months.
> > 	pajama1@mindspring.com and
> tdilling@oncodev.isc-net.upenn.edu are in
> > my linuxppc notes as being interested in hfs+
> development.
> > 	Also see this:
> >
> >
> http://developer.apple.com/technotes/tn/tn1150.html
> >
> > --- marv <omarvo@hotmail.com> wrote:
> > > Who's working HFS+ and can i help? I know some
> seem and i've been
> > > reading the kernel vfs docs and the hfs+ docs
> from apple.
> > > Reply directly because i was too lazy to join
> the mailing list
> > > although
> > > i did browse through the archives :P
>
> I am the one with the mostly non functional code for
> a kernel filesystem
> module for hfsplus.  The current code is available
> in my directory on
> devel.linuxppc.org as a patch against a 2.2.14
> kernel tree. However, the
> big problem now is that the filesystem structure
> doesn't seem to match
> what I got out of the Apple technote, which may be
> due to an error
> on my part or a lack of info from Apple. I haven't
> had the time to look
> into it carefully yet, but if you want to look, I'll
> do what I can to
> help. The URL is
> http://dev.linuxppc.org/pub/users/flar/ which has
> links to individual patches I have posted. The most
> recent patch as of
> this moment can mount a filesystem and has code to
> read directories and
> data forks of files, but sometimes misreads the
> catalog and loses track
> of files at odd times. It isn't likely to damage
> disks, but it does
> crash occasionally and cause strange errors.
>
> 	Brad Boyer
> 	flar@pants.nu
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
