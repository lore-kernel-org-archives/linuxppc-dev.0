Subject: Re: [patch] ignore trackpad/mouse while typing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Till Straumann <Till.Straumann@TU-Berlin.de>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
In-Reply-To: <20030125220422.A18276@ucw.cz>
References: <3DE6C428.5000403@TU-Berlin.de> <20030125184701.A16865@ucw.cz>
	 <1043521480.3684.32.camel@zion.wanadoo.fr>
	 <200301251558.30600.staikos@kde.org>  <20030125220422.A18276@ucw.cz>
Content-Type: text/plain
Message-Id: <1043529955.3683.41.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 25 Jan 2003 22:25:56 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-01-25 at 22:04, Vojtech Pavlik wrote:

> > > Well... the problem happpens in console as well, and with other
> > > non-X apps like MacOnLinux. Some Apple PowerBooks have over-sensitive
> > > trackpad. Apple themselves implement a similar mecanism in the kernel
> > > driver of OS X.
> >
> >   Mine is one of those machines.  I have to turn off gpm for sure, and X is
> > quite oversensitive too (tuned it in KDE, but still this functionality would
> > be very nice).
>
> How about implementing it in mousedev.c?

Right, though it would need hooks in kbddev or something to know
about keystrokes. Also, I don't like the sysctl's as those need
allocating sysctl numbers, which are always a problem. In 2.5,
we could have these in sysfs, though for 2.4 I'm not sure what
to do.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
