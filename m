To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
	<3ACB537B.99B851B9@netfall.com>
	<87hf0433qs.fsf@amadeus.openinformatics.com>
	<3ACB6167.3B2E0242@iiic.ethz.ch>
	<878zlg31mw.fsf@amadeus.openinformatics.com>
	<3ACB9611.C95D16A2@iiic.ethz.ch>
	<87ae5w1ce3.fsf@amadeus.openinformatics.com>
	<3ACB9EB3.2661FFCE@iiic.ethz.ch>
	<87u242zz7y.fsf@amadeus.openinformatics.com>
	<3ACCFFBB.58CC75D2@iiic.ethz.ch>
	<87itjmf7lf.fsf_-_@amadeus.openinformatics.com>
	<3AEDEF2D.4B823134@iiic.ethz.ch>
From: jason@openinformatics.com (Jason E. Stewart)
Date: 03 May 2001 20:10:31 -0600
In-Reply-To: <3AEDEF2D.4B823134@iiic.ethz.ch>
Message-ID: <87wv7x984o.fsf@amadeus.openinformatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michel Dänzer" <michdaen@iiic.ethz.ch> writes:

> I am reluctant to do that. I'd prefer to get a solution into XFree86.
>
> Someone please try the attached patch against current CVS. It turns Option
> "UseBIOSDisplay" (which probably doesn't work for us - no BIOS here...) into
> Option "Display" which accepts modes "CRT", "FP", "Mirror" and "BIOS".

Hey Michel,

I've had a heck of a time with this one. Using the new r128_drv.o that
I compile from the CVS HEAD gives me an error that the module is using
a newer ABI than the server...

So I compiled and installed the whole X package from CVS (into
/usr/X11R6-local using ProjectRoot). I get some strange behavior,
namely it doesn't find my .xsession and the keyboard input is messed
up (I have to type '1', 'n', '5', '3', '8') to type exit<return>.

I tried to use my old X configuration and it doesn't work at all,
server just hangs. I figured some configuration files in /etc/X11 must
have gotten stomped by the CVS install of X, so I ran dpkg --remove of
xserver-common and xserver-xfree86, followed by an apt-get install,
but it's still hosed.

Help???
jas.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
