Date: Fri, 30 May 2003 19:58:33 -0500
To: linas@austin.ibm.com
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
	Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>,
	linuxppc-dev@lists.linuxppc.org, linas@linas.org
Subject: Re: Kernel Panic in 2.2.x
Message-ID: <20030531005832.GA4272@backlot.linas.org>
References: <20030530113402.B29314@forte.austin.ibm.com> <7874ED64-92BD-11D7-A2DA-000A95A0560C@us.ibm.com> <20030530164822.A28086@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030530164822.A28086@forte.austin.ibm.com>
From: linas@linas.org (Linas Vepstas)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Hollis,


I got your reply, but don't have it here in front of me, so I can't
quote it. But ...

On Fri, May 30, 2003 at 04:48:22PM -0500, linas@austin.ibm.com was heard to remark:
> On Fri, May 30, 2003 at 11:40:49AM -0500, Hollis Blanchard wrote:
> > On Friday, May 30, 2003, at 11:34 US/Central, linas@austin.ibm.com
> > wrote:
> > >
> > > Latest & greatest is only the best if you are a developer.  For users,
> > > old-trustworthy is usually a much better bet.
> >
> > I disagree,
>
> OK, I can't just let this one slide.

In your reply, you talk mostly of Linux desktop apps, and new hardware.
Lets not dismiss the problem by false analogy.

-- New hardware (e.g. laptop which won't go into sleep mode)  does
   require new software, drivers, etc. But that's OK, cause its new
   hardware, not an upgrade.  I have nothing against new software:
   I create a lot of it, and I use a lot of it.

-- You also mention desktop apps. Yes, the linux desktop has been
   moving rapidly, and it is reasonable to assume that some users want
   to upgrade old hardware to use the new desktops. (instead of
   buying new hardware that actually has things like USB on it).

   But beware of turning the home user into an inadvertant sysadmin.
   When your home user becomes the sysadmin, they will rapidly come
   to hate you.

   A little annecdote: I 'inherited' a late-model Win98 box.  I 'loaned'
   it to my 6 year old.  Who used it happily.  One day, we got a new
   game that required a new 'macromedia flash'.  OK, I'm a big man,
   'I can do this', I say to myself.  It pre-req'ed an newer version
   of apple's 'quicktime veiwer'.  This pre-req'ed a pile of Win98
   upgrades from Microsoft, about 25MB worth.  I think it must have
   been an automated Win98SE upgrade.  Took a while to download.  When
   done, the sound card didn't work.  My 6 year old was unhappy.  The
   next day, 10 drivers later, sound still doesn't work.  Every nite,
   I come home, my 6 year old hovers waiting to get the computer back.
   This goes on for 5 evenings in a row.  In furstration, I tell him,
   sorry, computer's ba-ba.  We have discussion about piggy-banks and
   cost of new computer, and how spare change isn't gonna solve it.
   Next week a freind offers to pirate a copy of WinXP for me, he
   says its pretty good, he likes it.  I almost go for it: one thought
   holds me back:  new software sometimes has a real problem with
   old hardware.  I might be jumping from frying pan into fire on such
   an upgrade. Sometime, a few weeks later, after we've given up on it,
   I'm toying around, install the sound driver one more time, one more
   reboot, magic! it starts working!  Oh, and the game that required
   the software update? It still didn't work.

   Moral of the story? Even desktop users can be turned into sysadmins.

   (BTW, I am the proud co-author of gnucash, which, if you read the
   trade-press, is in the top-10, if not ranked #1 in the category of
   'most difficult-to-install Linux desktop software'.  Of which I'm
   *not* proud of. But what can one do?  How else can one add new
   features? So I understand the other side of the coin pretty well.)

Linux is real strong in the server space, weak in the desktop.  Server
'users' are almost exclusively sysadmins.  They run systems for 5 years
or more.  (my www.linas.org is an 9 year old Dell 486.  www.gnucash.org
is 3.5 years old)  When a server goes down, hundreds of users are
affected.  (each of the www.gnucash.org mailing lists have 500+
subscribers, I move 7-10 GBytes a month.).  I think we need to make sure
that Linux in the server space benefits the sysadmin, and this means
very conservative design principles, and conservative installers
(something that really can backout the new version and replace old
version).   God help us all if one day Microsoft succeeds in building
a system that is easier to install/upgrade/manage than a Linux server.
Don't bite the hand that is currently feeding Linux.

--linas

--
pub  1024D/01045933 2001-02-01 Linas Vepstas (Labas!) <linas@linas.org>
PGP Key fingerprint = 8305 2521 6000 0B5E 8984  3F54 64A9 9A82 0104 5933

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
