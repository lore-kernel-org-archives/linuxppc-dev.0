Date: Tue, 27 Apr 2004 09:18:06 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
In-Reply-To: <408E000A.6040303@fh-landshut.de>
Message-ID: <Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
 <20040426220944.GI19246@smtp.west.cox.net> <408E000A.6040303@fh-landshut.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Apr 2004, Oliver Korpilla wrote:

> >>Is this even possible with the PPCbug, or do I need a Linux-friendly
> >>bootloader? I initially guessed, that if at bootup everything is
...
> >It works from PPCBug.  At least with cramfs, I _believe_ there is, or
> >has been a problem with creating an image on an LE machine for a BE
...
> Tried this initially, and it didn't work - will try again, to supply you
> with the exact messages later today (I'm not in work yet - lazy, lazy! :) )

Please do so. We're booting initrd images from PPC-Bug fine over here
(MVME2700), so I'd be interested in potential catches.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
