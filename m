Message-ID: <37EDA5EB.B3BD8313@home.com>
Date: Sat, 25 Sep 1999 22:49:47 -0600
From: Neil Jolly <njolly@home.com>
MIME-Version: 1.0
To: yellowdog-general@lists.yellowdoglinux.com
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        mklinux-setup@public.lists.apple.com
Subject: Re: XFree86-3.3.5-1.6.0b
References: <Pine.LNX.4.10.9909251336400.8691-100000@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> Hello again all.
>
> I've uploaded XFree86-3.3.5-1.6.0b rpms to
> ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5
> If you installed 3.3.5-1.6.0a, and use FBDev, you only need to update that
> particular RPM.  If you use Xpmac, nothing should have changed.  This

Tom: I installed XFree86-FBDev-3.3.5-1.6.0b only as directed, ran
Xconfigurator, and configured 8 bit, 16 bit, and 24 bit. I checked XF86Config
and it was configured for 8 bit, 15 bit, and 24 bit depths. Testing worked
fine in 8 bit, starting X with startx --  -bpp 16 worked ( wasn't sure if I
should use 15 or 16), and startx --  -bpp 24 also worked, but was quite
distorted. Sort of like looking through a kaliedoscope with 4 quadrants -
kind of reminded me of the 70s ;-). Running Xconfigurator & stting up only a
16 bit mode, or only a 24 bit mode would cause X to fail with a default 8 bit
mode not configured (more or less) message. I've gone back to the first rpm
now, but Ill try anything else you can suggest.


--
Neil Jolly
(with Yoda-like voice)
"Confrontation leads to anger...  Anger leads to fear...  Fear leads
to using Windows NT in mission-critical combat systems...  And this is
how the ancients fell...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
