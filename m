Message-Id: <200210221503.RAA21965@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 17:00:23 +0200
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr> <20021022163130.5160@192.168.4.1>
In-Reply-To: <20021022163130.5160@192.168.4.1>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >But I don't know how to make xfree86 to use radeonfb.

> Use "fbdev" as the driver in xfree, that will cause X to
> run unaccelerated on top of radeonfb, so it will at least
> be able to set mode & colors properly.
>
> I think support for the 9000 have been added to XFree CVS
> recently, though that may not yet be in the DRI one (and
> so Michel snapshots). The XFree CVS is beeing merged
> again into the DRI one now, so this should be fixed soon.

where can I find the .deb files from Michel, please ?

xavier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
