Date: Wed, 15 Sep 1999 10:22:22 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Ethan Benson <erbenson@alaska.net>
cc: "Timothy A. Seufert" <tas@mindspring.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
In-Reply-To: <v04210105b404ed46f043@[192.168.0.1]>
Message-ID: <Pine.LNX.3.96.990915100107.32318D-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Sep 1999, Ethan Benson wrote:

> On 14/9/99 Timothy A. Seufert wrote:
> 
> >In fact, I think that's just what OS X does on New World machines.  I
> >recall that it creates a small partition named "Rhapsody Booter" or some
> >such thing.
> 
> yes it does this on all machines, and frankly I think its a 
> disgusting kludge, that would be OK as a absolute LAST RESORT *after* 
> all attempts to get a proper booter working have failed.

That _is_ a proper booter.  I assume you mean that having a booter should
be a last resort after you can't get direct OF loading to work....


> linux in my view is about doing things better, and doing them *right* 
> Linus himself is fairly picky about doing things right instead of 
> doing a kludge that `works'
> 
> Apple's attitude seems to be `why do it right when a kludge will do?' 
> I do not want to see linux choose the same philosophy.

I am, frankly, offended by that statement.  You're talking about what you
see now and using the words "MacOS X".  What you see now doesn't even
remotely resemble MacOS X code-wise.  It's MacOS X Server, not MacOS X. 
Different kernel, totally different source base, probably a different boot
mechanism.

The fact that the current "temporary" code uses what you describe as a
kludge does _not_ in any way mean that Apple's attitude is to use a kludge
instead of doing things right.  MacOS X Server was never intended to be
anything more than a series of hacks to get people by until the real code
comes out.  Period.


> sorry to be blunt but just because apple has chosen to kludge their 
> bootloader does NOT mean that is what we should do.

Doing it "right" means ripping Apple's BrokenFirmware (tm) off the boards
and rewriting it so that everything works.  Short of that, all boot
methods are kludges.  The choice here is whether you want to have to boot
half-way into MacOS (BootX) or have a way that doesn't require any
licensing to distribute in a bootable form (this new thing).

Also, to say that Linux does things "right" is ridiculous.  Linux x86 has
loadlin, which loads from DOS (kinda like BootX app), and syslinux, which
seems similar to what this new booter is doing.  Booting by OF is kind of
like booting with x86's lilo, which isn't always possible on all drives
in all configurations.  That's why they have other things like syslinux
and loadlin.  That's why LinuxPPC has BootX and now... well, whatever this
thing is called... BootY?

In conclusion, Linux has, and always will have kludges as alternative boot
mechanisms for machines that can't boot in the traditional way.  There's
simply no way around it if you want to support a wide range of machines.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
