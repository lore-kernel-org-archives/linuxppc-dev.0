Message-ID: <3D6BB90F.43630CB6@opensource.se>
Date: Tue, 27 Aug 2002 19:38:23 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Marius Groeger <mag@sysgo.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Password on ELDK nfs booting
References: <20020827140443.4679E1182F@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've made a patch for e2fsprogs that makes it possible
to use debugfs to create ext2-images from userspace.

If that program is used together with fakeroot
it's possible to do everything* without root access.

*if everything is generating your target filesystem with
correct permissions and uids/gids

I think that is nice.

Mail me if you want the patch.

/ magnus

Wolfgang Denk wrote:
>
> In message <Pine.LNX.4.40.0208271536520.3441-100000@mag.devdep.sysgo.de> you wrote:
> >
> > > It seems you are using devfs; try running without  it.  I  don't  see
> > > much   advantages   of  devfs  for  embedded  systems  where  such  a
> > > flexibility is usually not needed, on contrary.
> >
> > Well, I see at least two advantages: a) you don't need to have root
> > privileges to assemble your root-filesystem, b) it's the way /dev
> > should have been implemented in the first place.
> >
> > I admid both arguments cover rather aesthetical aspects, so your
> > mileage may vary.
>
> The main disadvantage is the increased  memory  footprint  which  you
> have  to  pay  for  a  flexibility on the target which is usually not
> necessary.
>
> Your (a) is not really an argument; there are several  solutions  for
> this "problem", for example:
>
>         genext2fs - ext2 filesystem generator for embedded systems
>                 see http://packages.debian.org/unstable/admin/genext2fs.html
>
>         gBootRoot - distribution creation program which may be used by a normal user
>                 see http://gbootroot.sourceforge.net/
>
> (b) is a matter of taste; for embedded systems, I tend  to  prefer  a
> fixed,  static  configuration  which  does  not  cost too much of the
> resources which may be somewhat limited (espacially ROM and RAM).
>
> Yes, MMV ;-)
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> By the way, ALL software projects are done by iterative  prototyping.
> Some companies call their prototypes "releases", that's all.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
