To: linuxppc-dev@lists.linuxppc.org
Subject: It does! (was: Re: Does a Cinema Display work under Linux?)
References: <Pine.LNX.3.96.1000503111322.24757M-100000@deepspace.mklinux.org>
	<8x4s8a1h9m.fsf@s61.informatik.uni-bremen.de>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 09 May 2000 17:00:06 +0200
In-Reply-To: Holger Bettag's message of 07 May 2000 18:01:25 +0200
Message-ID: <8xk8h3py4p.fsf_-_@s61.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag <hobold@Informatik.Uni-Bremen.DE> writes:

[Following up on myself]

> My G4 and the Cinema Display finally arrived. Needless to say, nothing works
> as of yet. :-)
>
[very detailed list of my stupid mistakes deleted]

After looking at the various install scripts, I finally understood the
installation process good enough to avoid all the stupid mistakes I made
earlier. Installation went painless then.

Two simple lines with "novideo" in yaboot.conf are enough to make the Cinema
Display work 'good enough' during installation and for a running system. This
was simpler than I expected. (The CinDis runs in its native resolution with
8 bits color depth, unaccelerated.)


I have looked at the development kits available on ATI's web site. None of
them is directly related to driver programming. I can try to register with ATI,
but I don't have a 'big name' company to back me up, so I think my chances
aren't very high.

I have been thinking that maybe there might be other options, like becoming a
betatester for one of the parties that already have ATI's blessing. I'd
honor the necessary NDAs, and I'd do some programming to improve the support
for digitally connected displays.

Is anyone interested?

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
