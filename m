To: Marius Groeger <mag@sysgo.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Password on ELDK nfs booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Aug 2002 15:45:11 +0200."
             <Pine.LNX.4.40.0208271536520.3441-100000@mag.devdep.sysgo.de>
Date: Tue, 27 Aug 2002 16:04:38 +0200
Message-Id: <20020827140443.4679E1182F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.40.0208271536520.3441-100000@mag.devdep.sysgo.de> you wrote:
>
> > It seems you are using devfs; try running without  it.  I  don't  see
> > much   advantages   of  devfs  for  embedded  systems  where  such  a
> > flexibility is usually not needed, on contrary.
>
> Well, I see at least two advantages: a) you don't need to have root
> privileges to assemble your root-filesystem, b) it's the way /dev
> should have been implemented in the first place.
>
> I admid both arguments cover rather aesthetical aspects, so your
> mileage may vary.

The main disadvantage is the increased  memory  footprint  which  you
have  to  pay  for  a  flexibility on the target which is usually not
necessary.

Your (a) is not really an argument; there are several  solutions  for
this "problem", for example:

	genext2fs - ext2 filesystem generator for embedded systems
		see http://packages.debian.org/unstable/admin/genext2fs.html

	gBootRoot - distribution creation program which may be used by a normal user
		see http://gbootroot.sourceforge.net/

(b) is a matter of taste; for embedded systems, I tend  to  prefer  a
fixed,  static  configuration  which  does  not  cost too much of the
resources which may be somewhat limited (espacially ROM and RAM).

Yes, MMV ;-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
