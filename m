Date: Fri, 6 Apr 2001 13:04:52 +1000
From: Steven Hanley <sjh@svana.org>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
Message-ID: <20010406130452.B515@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net> <3ACB537B.99B851B9@netfall.com> <87hf0433qs.fsf@amadeus.openinformatics.com> <3ACB6167.3B2E0242@iiic.ethz.ch> <878zlg31mw.fsf@amadeus.openinformatics.com> <3ACB9611.C95D16A2@iiic.ethz.ch> <87ae5w1ce3.fsf@amadeus.openinformatics.com> <3ACB9EB3.2661FFCE@iiic.ethz.ch> <87u242zz7y.fsf@amadeus.openinformatics.com> <3ACCFFBB.58CC75D2@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3ACCFFBB.58CC75D2@iiic.ethz.ch>; from michdaen@iiic.ethz.ch on Fri, Apr 06, 2001 at 01:28:59AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 06, 2001 at 01:28:59AM +0200, Michel Dänzer wrote:
> You'd have to set ProjectRoot in host.def before the build.

it is detailed nicely on http://dri.sourceforge.net/doc/DRIcompile.html

which also mentions

9.3 Update Locale Information

To update your X locale information do the following:

             cd ~/DRI-CVS/build/xc/nls
             ../config/util/xmkmf -a
             make
             make install


This will prevent a locale error message from being printed when you run
Xlib programs.


which I defintely reccomend doing, and I wonder why the how to compile X
guuides never seem to mention this that I have seen, the first time I
compiled X 4 for my pismo  I was wondering for about a month why I was
getting the locale error, until I compiled dri server and followed those
directions I still didnt know. From what I can tell when you build all of X
this is done anyway, but not when you build server only.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
