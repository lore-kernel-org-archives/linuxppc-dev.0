From: kd@flaga.is
Subject: Re: NFS problem
To: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF72F9218C.C672231C-ON00256874.0047BF75@flaga.is>
Date: Fri, 28 Jan 2000 13:08:35 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



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
