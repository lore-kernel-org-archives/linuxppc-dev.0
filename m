Date: Fri, 12 Jul 2002 15:31:57 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: sh: tcsetpgrp: Inappropriate ioctl for device
In-Reply-To: <A1C99F4731CAD111BA5400A024FC3B0CCD0938@ESBILMA01EDCGE>
Message-ID: <Pine.LNX.4.40.0207121526570.6724-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 11 Jul 2002, Billalabeitia, Jose Carlos (IndSys, GEPM) wrote:

> busybox 0.51. Every time an script is executed in
> the console I get the message:
>
> 	"sh: tcsetpgrp: Inappropriate ioctl for device"

Edit the lash source. AFAIK there are 4 locations with that perror().
My memory is a little bit (well, very) fuzzy on this, but I recall
that you can safely ignore this error and comment out those perrors().

BTW, the lash shell in this version is indeed somewhat "lame". You may
want to try a more current version of BusyBox. It comes with a total
of 4 shells to choose from, some also including bourne shell control
statements.

Regards
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
