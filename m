Date: Wed, 21 Nov 2001 23:31:21 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: benh@kernel.crashing.org
Cc: Marcus Metzler <mocm@metzlerbros.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
In-Reply-To: <20011121182716.31026@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.40.0111212318540.10065-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 21 Nov 2001 benh@kernel.crashing.org wrote:

> Note that working firewire for pismo/tipb exist in my rsync tree
> or in the linux1394 CVS. Linus and bk _devel aren't up-to-date yet.

Well, I've just successfully loaded the 'ohci1394' driver on this iBook. I
don't have any actual FireWire devices available to plug into it right
_now_, but this is a step in the right direction, in that it didn't
proceed to hang up the PMU and shut the unit down. Maybe on Friday I'll
scoot out to work and plug in the 12x FireWire CD burner we have laying
around, and see if I can burn something. (Or at least read something -
that'd be progress.) (This is with 2.4.15-pre6-ben0, but I would presume
-pre7-ben0 would be the same story, but I haven't tried it yet.

I don't know what yoou changed, Ben, but I would say this is a major step
in the right direction. If it now proceeds to work right, then the only
remaining area of contention on this iBook with Linux will be DRI/AGP.
(Not really major to me, so for all practical purposes, that'd be
everything I care about.)

Hell, I'm tempted to make the half-hour trip to work, get the burner,
bring it back, and try it, even given the late hour. :)

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
