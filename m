Date: Wed, 26 Jun 2002 15:51:42 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: SELF and JFFS2????
Message-ID: <Pine.LNX.4.40.0206261547340.1779-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

> has anyone successfully used DENX SELF to create an root fs _and_ put it
> then on a JFFS2 partion?

FWIW, the Elinos DevKit contains an example project to do just that. It
allows to format the MTD device, and download and install another project
onto it.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
