Subject: RE: Free ppc linux configuation tool?
From: Jeff Angielski <jeff@theptrgroup.com>
To: "listmember@orkun.us" <listmember@orkun.us>
Cc: "Kerl, John" <John.Kerl@Avnet.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <29449.216.110.51.8.1071877375.squirrel@www.orkun.us>
References: <C7FFFEA58B43D311920D0004ACE5333F10E4F46C@amer25.avnet.com>
	 <29449.216.110.51.8.1071877375.squirrel@www.orkun.us>
Content-Type: text/plain
Message-Id: <1072105831.4163.15.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 22 Dec 2003 10:10:31 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you look at the Makefile to make sure the ARCH is set correctly?

Jeff Angielski
The PTR Group

On Fri, 2003-12-19 at 18:42, listmember@orkun.us wrote:
> Well, I am trying to use the sources for kernel 2.4.23 downloaded at:
>
> http://www.ppckernel.org/download/source/src-linuxppc_2_4.tar.bz2
>
> When I do make menuconfig or make xconfig I did not get an PowerPC choice.
> What am I doing wrong. I was in the process of creating the .config file
> manually but that is a rather time consuming and error prone process. I
> would like to configure most if not all settings by a tools if possile.
>
> > Erm, make menuconfig at the base of your kernel tree?
> > Or were you looking for something else?  E.g. Embedix
> > (now out of business, I think) had a Windows-style
> > wizard interface, which as I recall was merely shellac
> > on make xconfig.
> >
> > -----Original Message-----
> > From: listmember@orkun.us [mailto:listmember@orkun.us]
> > Sent: Friday, December 19, 2003 1:19 PM
> > To: linuxppc-embedded@lists.linuxppc.org
> > Subject: Free ppc linux configuation tool?
> >
> >
> >
> > Sorry for duplicate posting, I forgot to specify a subject first time...
> >
> > I am creating a linux .config file for an embedded PowerPC 405gp board.
> >
> > Is there a menu driven free tool (console or X11 based) to assist me?
> >
> > I read somewhere about Montavista Hardhat Linux Configuration Tool but I
> > am not sure if it is available free.
> >
> > Regards,
> > Tolunay
> >
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
