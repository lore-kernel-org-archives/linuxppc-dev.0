Date: Thu, 27 Jun 2002 11:03:24 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SELF and JFFS2????
In-Reply-To: <3D1ACE16.130836D0@imc-berlin.de>
Message-ID: <Pine.LNX.4.40.0206271056180.1320-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 27 Jun 2002, Steven Scholz wrote:

> > > So you're going to delight us with a copy (just to present the idea) of the
> > > build scripts...!? ;-)
> >
> > Build scripts what for - the CDK?
> >
>
> No. The topic here was "creating a flash disk (JFFS2) instead of a initrd"...

Ah, well obviously the Build-Scripts are our work, and are not GPLed.
You do get their source code with Elinos, though. The idea (which you
asked for) is simple enough: Project A boots the target. It has
Networking and MTD built in. An installer tool (shipped with source
code) does the following:

- configure the network i/f
- format the MTD block dev(s).
- download (streaming, actually, to allow for unlimited size) and
  install the kernel image and root file system of Project B

> fs. Do you know the ELDK?

No (not yet, at least).

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
