Date: Fri, 22 Dec 2000 00:15:46 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
In-Reply-To: <19341115163822.14429@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10012220013370.30272-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Neither does it change anything for me (Lombard, SCSI Zip and Quantum
> >VP32210). I've not tried to force any bus resets or something weird
> >though.
>
> Well, I didn't change mesh_reset(), only mesh_init(). Since it seem that

I saw mesh_init called in more than one spot on a quick glance over the
source and must have incorrectly assumed it's also used on bus or host
reset.

> it doesn't break working configs but actually fix some non working ones,
> I'll push it one of these days.

In case it wasn't obvious: my setup was working perfectly fine even before
the patch :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
