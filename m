Subject: Re: firewire in 2.4.21-ben2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Calum Selkirk <cselkirk@xs4all.nl>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030726143945.GJ24614@xs4all.nl>
References: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com>
	 <1058261452.628.36.camel@gaston> <20030717101149.GA2393@xs4all.nl>
	 <20030726143945.GJ24614@xs4all.nl>
Content-Type: text/plain
Message-Id: <1059321991.529.4.camel@gaston>
Mime-Version: 1.0
Date: 27 Jul 2003 12:06:31 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-07-26 at 10:39, Calum Selkirk wrote:
> * Calum Selkirk [cselkirk@xs4all.nl] [2003-07-17 12:11 +0200]:
>
> > * Benjamin Herrenschmidt [benh@kernel.crashing.org] [2003-07-15 11:30 +0200]:
> >
> > [snip]
> > > >   After I reboot back in 2.4.20-ben10 everything works fine...
> > >
> > > That's a change in the firewire layer, you have to trigger a scsi
> > > probe yourself now. Either using the rescan-scsi-bus.sh script, or the
> > > scsiadd command for example
> >
> > just FYI, I have had the kernel oops on one occasion when rescaning the
> > scsi bus this way (with a 2.4.21-ben2). Sorry, wasn't able to get a
> > backtrace, though I will attempt to if it happens again.
>
> OK .. attatched is a backtrace (hopefully accuratly transcribed) and
> snippit from /var/log/messages.
>
> As i said previously I haven't been able to reproduce this, it's only
> happened to me on one occassion (the above backtrace is from another
> user/machine). Might this be related to the other ieee1394 bug, where
> unloading ohci1394 after sleep will oops?

A backtrace with just numbers is useless, you should either provide
insmod -m output or run the oops through ksymoops.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
