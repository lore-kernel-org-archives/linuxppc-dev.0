Subject: Re: just compiled a 2.4.19 kernel with smp support...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200210221503.RAA21965@ipnmail.in2p3.fr>
References: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr>
	<20021022163130.5160@192.168.4.1>  <200210221503.RAA21965@ipnmail.in2p3.fr>
Content-Type: text/plain; charset=ISO-8859-1
Date: 22 Oct 2002 17:27:45 +0200
Message-Id: <1035300466.1129.1904.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Die, 2002-10-22 at 17:00, Xavier Grave wrote:
>
> > >But I don't know how to make xfree86 to use radeonfb.
>
> > Use "fbdev" as the driver in xfree, that will cause X to
> > run unaccelerated on top of radeonfb, so it will at least
> > be able to set mode & colors properly.
> >
> > I think support for the 9000 have been added to XFree CVS
> > recently, though that may not yet be in the DRI one (and
> > so Michel snapshots). The XFree CVS is beeing merged
> > again into the DRI one now, so this should be fixed soon.
>
> where can I find the .deb files from Michel, please ?

http://dri.sourceforge.net/snapshots/README.Debian

Beware that the radeon 2D driver is still basically 4.2.0.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
