To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 fixlets
References: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
	<1061496837.18043.1.camel@gaston>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Fri, 22 Aug 2003 13:39:36 +0200
In-Reply-To: <1061496837.18043.1.camel@gaston> (Benjamin Herrenschmidt's
 message of "21 Aug 2003 22:13:57 +0200")
Message-ID: <87wud5vs3r.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> I'm preparing a new set of patches that include all my driver
> changes except the video ones. I'll send those ones separately to
> James first as they rely on some fbdev infrastructure changes.

Does this set contain any audio fixes (either alsa or dmasound) for
the tumbler (ibook2 - late 2001)?

Alsa does not seem to produce any sound, whatever I try to do (including
messing around with mute), and dmasound doesn't compile at all.

Used kernel is 2.6.0-test3, via rsync from source.mvista.com::linuxppc-2.5,
as of around 10AM CET (8AM UTC).

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
