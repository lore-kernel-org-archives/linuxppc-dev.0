Date: Wed, 13 Jan 1999 13:10:16 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Michael Meissner <meissner@cygnus.com>
cc: linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <199901122243.RAA16378@tiktok.cygnus.com>
Message-ID: <Pine.LNX.3.96.990113130844.3715A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It looks like your zImage is being stomped on before it can be
decompressed.  I'll take a look at the boot loader code and see why it
isn't adjusting your free ram section.  You might want to try changing to
load address in the PPCBug to be near the top of memory in the mean time.


}	loaded at:     00400400 00415FD0
}	relocated to:  00600000 00615BD0
}	zimage at:     0040A400 0049A889
}	avail ram:     00400000 00600000
}
}	Linux/PPC load: console=tty0 console=ttyS0,9600n8 root=/dev/sda2 mem=127M
}	Uncompressing Linux...done.
}	Now booting the kernel


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
