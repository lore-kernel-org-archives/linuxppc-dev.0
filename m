To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-user@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org, mklinux-setup@public.lists.apple.com
Subject: Re: XFree86-3.3.5-1.6.0b
References: <Pine.LNX.4.10.9909251336400.8691-100000@opus.bloom.county>
Reply-To: minyard@acm.org
From: minyard@acm.org
Date: 26 Sep 1999 16:21:04 -0400
In-Reply-To: Tom Rini's message of "Sat, 25 Sep 1999 13:57:23 -0700 (MST)"
Message-ID: <m2u2oh77bj.fsf@morse.concentric.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It's not working on my Lombard in 24-bit mode.  15-bit mode works
fine.  Specifically, the server says:

   No valid modes found

at startup when 24bpp is specified.  It doesn't say why it is not
valid, it just doesn't work.  Since it works in 15bpp mode, that seems
rather odd.

Also, my font server stopped working.  It would lock the machine up at
startup.  Actually, the machine wasn't locked up, but it wouldn't
finish booting since xfs didn't "daemonize" properly, it seems. I had
to remove it from the rc directories.

Also, starting the screen saver causes the following:

  Fatal server error:
  fbdevUpdateColormap: FBIOPUTCMAP failed (Function not implemented)

That would be nice to have fixed.  This did the same thing for 3.3.3.


Tom Rini <trini@kernel.crashing.org> writes:

> Hello again all.
> 
> I've uploaded XFree86-3.3.5-1.6.0b rpms to
> ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5
> If you installed 3.3.5-1.6.0a, and use FBDev, you only need to update that
> particular RPM.  If you use Xpmac, nothing should have changed.  This
> should fix most of the invalid depth/etc problems when trying to do >16.
> 
> Compiling w/ egcs 1.1.2-12f did not fix at least the main accel bug
> (crash), so this is built vs 2.95.x as well.  More feedback/etc is
> welcome.
> 
> ---
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
