Message-Id: <s891a235.023@mail.frequentis.com>
Date: Fri, 28 Jan 2000 14:04:53 +0100
From: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
To: <kd@flaga.is>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NFS problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am typing sync permanently on both sides. It shortens the time for the update, but still it is not direct.
Ralf

>>> <kd@flaga.is> 01/28/00 02:08pm >>>

Type sync on both your board and your nfs host before accessing the files
on the board.

There is probably a bug somewhere, probably in the NFS server. I am using
Debian 2.1 (slink). I have not bothered to track it down, I just type some
extra syncs.

K.D.


Ralf wrote:

I am booting from an NFS server and have a strange effect. When files are
deleted or updated on the server, the board for a whole while still uses
the old versions of the files before it notices the update.
What do I have to do to make them more synchronized?

Thanks,
Ralf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
