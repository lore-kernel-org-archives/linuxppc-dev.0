Date: Tue, 16 Feb 1999 23:23:42 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs
In-Reply-To: <19990216191148.002398@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990216232259.32682A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The same sort of thing (optimistic disable) is in the real-time linux
system.  I want to add it when that comes in.

}Mach maintains the current interrupt mask locally in RAM. When it
}disables an interrupt, it does so only in the mask, the controller gets
}updated only if this interrupt actually occurs. The enable code will
}enable it in the mask only if it has been disabled by the interrupt.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
