Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Date: Fri, 12 Oct 2001 15:52:07 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
References: <200110121858.f9CIwnY14960@aslan.scsiguy.com>
In-Reply-To: <200110121858.f9CIwnY14960@aslan.scsiguy.com>
MIME-Version: 1.0
Message-Id: <20011012194947.SUPU19094.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Justin,

> >So can you point me to where in your driver code the depth of the
> > tagged queueing is dynamically determined?  I would like to play
> > around a bit with the driver code to see if I can tell if the Quantum
> > Fireball is simply spitting back bogus info or and if so what?
>
> I can already tell you what is happening.  We send a bunch of commands
> to the drive expecting it to respond with QUEUE FULL status should we
> send too many, but the drive instead accepts them for future completion
> but never actually responds to the commands.  This is why we time out.

So there is really nothing anyone can do about it?  I will just need to
keep the tag depth at 8 for that drive.

Earlier you said something about a firmware upgrade for those drives?
Would a firmware upgrade help solve this issue more cleanly or given that
it is now working should I just forget about it and leave well enough
alone.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
