Date: Fri, 12 Feb 1999 17:55:31 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Matt Porter <mmporter@home.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: platform specs (was: PReP spec)
In-Reply-To: <Pine.LNX.3.96.990212165724.2030D-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.96.990212175439.19379A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That's not chrp, though.  That's just a chrp memmap.  The kernel doesn't
yet deal with a chrp memmap and no-OF.  I'd rather stick with prep memmaps
with those boards - it's simple.

}And from the looks of things, all new Motorola boards/systems.  Already,
}VxWorks BSPs for Moto. boards are easily configured to a CHRP mem map.
}Only the firmware defaults to PReP and it is getting dated with its poor
}PCI mapping.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
