Message-Id: <v03130303b4058a912561@[17.202.21.235]>
In-Reply-To: <19990915135712.011244@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 15 Sep 1999 10:42:33 -0700
To: Benjamin Herrenschmidt <bh40@calva.net>
From: Peter Bierman <bierman@apple.com>
Subject: Re: More OF booting
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:57 PM +0200 9/15/99, Benjamin Herrenschmidt wrote:
>Another thing I discovered recently is that there is an update for the
>firmware of Apple's Symbios 53C875 SCSI board that used to be shipped
>with Beige G3s. This update makes it OF compatible and is part of the
>MacOS X Server installation.
>
>Currently, I think there is no other way to update the board, you have to
>launch MacOS X Server installer, it's apparently not included in Darwin's
>installer and is not available as a separate tool.

You can launch it manually from the "Upgrader Items" folder somewhere in
the Mac OS X Server Installer folder.

It won't be run automagically for you in the future installer, but I'm
trying to make sure the updater itself gets put on the CD. And I'll see if
I can get it posted on the Apple Software Updates pages; I didn't see it
there last I looked.

-pmb

--
"UNIX shells in Mac OS X should be unneeded but functional...
                        and have the same installed base as MPW."


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
